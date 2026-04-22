package main
 
import (
    "context"
    "database/sql"
    "encoding/json"
    "log"
    "net"
    "net/http"
    "strconv"
 
    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/secretsmanager"
    "github.com/gin-gonic/gin"
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
    _ "github.com/lib/pq"
)
 
var db *gorm.DB
 
type Student struct {
    Name       string `json:"name" gorm:"column:name"`
    RollNo     string `json:"roll_no" gorm:"primaryKey;column:roll_no"`
    Department string `json:"department" gorm:"column:department"`
}
 
type DbCredentials struct {
    DBUser     string `json:"DB_USER"`
    DBHost     string `json:"DB_HOST"`
    DBPassword string `json:"DB_PASSWORD"`
    DBPort     int    `json:"DB_PORT"`
    DBName     string `json:"DB_NAME"`
    DBSSLMode  string `json:"DB_SSLMODE"`
}
 
func loadSecret() (*DbCredentials, error) {
    secretName := "db_credentials"
    region := "us-east-1"
 

    cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion(region))
    if err != nil {
        return nil, err
    }
 
 
    svc := secretsmanager.NewFromConfig(cfg)
 

    input := &secretsmanager.GetSecretValueInput{
        SecretId:     &secretName,
        VersionStage: aws.String("AWSCURRENT"),
    }
    result, err := svc.GetSecretValue(context.TODO(), input)
    if err != nil {
        return nil, err
    }
 

    var credentials DbCredentials
    if err := json.Unmarshal([]byte(*result.SecretString), &credentials); err != nil {
        return nil, err
    }
    return &credentials, nil
}
 
func getConnectionString(credentials *DbCredentials) string {
    return "user=" + credentials.DBUser + " host=" + credentials.DBHost + " password=" + credentials.DBPassword + " port=" + strconv.Itoa(credentials.DBPort) +
        " dbname=" + credentials.DBName + " sslmode=" + credentials.DBSSLMode
}
 
func createDBIfNotExists(credentials *DbCredentials) {
    psqlInfo := getConnectionString(credentials)
    sqlDB, err := sql.Open("postgres", psqlInfo)
    if err != nil {
        log.Fatal("Failed to connect to PostgreSQL:", err)
    }
    defer sqlDB.Close()
 
    var exists bool
    err = sqlDB.QueryRow("SELECT EXISTS(SELECT datname FROM pg_catalog.pg_database WHERE datname = $1)", credentials.DBName).Scan(&exists)
    if err != nil {
        log.Fatal("Failed to check if database exists:", err)
    }
    if !exists {
        _, err = sqlDB.Exec("CREATE DATABASE " + credentials.DBName)
        if err != nil {
            log.Fatal("Failed to create database:", err)
        }
        log.Println("Database created successfully")
    } else {
        log.Println("Database already exists")
    }
}
 
func initDB() {
    credentials, err := loadSecret()
    if err != nil {
        log.Fatalf("Failed to load secrets: %v", err)
    }
    createDBIfNotExists(credentials)
    dsn := getConnectionString(credentials)
    db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
    if err != nil {
        log.Fatal("Failed to connect to the database:", err)
    }
    if err := db.AutoMigrate(&Student{}); err != nil {
        log.Fatal("Failed to migrate database:", err)
    }
}
 
func getStudents(c *gin.Context) {
    var students []Student
    if result := db.Find(&students); result.Error != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error retrieving students"})
        return
    }
    c.JSON(http.StatusOK, students)
}
 
func getStudent(c *gin.Context) {
    rollNo := c.Param("roll_no")
    var student Student
    if result := db.First(&student, "roll_no = ?", rollNo); result.Error != nil {
        c.JSON(http.StatusNotFound, gin.H{"error": "Student not found"})
        return
    }
    c.JSON(http.StatusOK, student)
}
 
func createStudent(c *gin.Context) {
    var student Student
    if err := c.ShouldBindJSON(&student); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
        return
    }
    if result := db.Create(&student); result.Error != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error creating student"})
        return
    }
    c.JSON(http.StatusCreated, gin.H{"message": "Student created successfully", "student": student})
}
 
func updateStudent(c *gin.Context) {
    rollNo := c.Param("roll_no")
    var student Student
    if result := db.First(&student, "roll_no = ?", rollNo); result.Error != nil {
        c.JSON(http.StatusNotFound, gin.H{"error": "Student not found"})
        return
    }
    if err := c.ShouldBindJSON(&student); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
        return
    }
    if result := db.Save(&student); result.Error != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error updating student"})
        return
    }
    c.JSON(http.StatusOK, gin.H{"message": "Student updated successfully", "student": student})
}
 
func deleteStudent(c *gin.Context) {
    rollNo := c.Param("roll_no")
    if result := db.Delete(&Student{}, "roll_no = ?", rollNo); result.Error != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Error deleting student"})
        return
    }
    c.JSON(http.StatusOK, gin.H{"message": "Student deleted successfully"})
}
 
func main() {
    initDB()
    router := gin.Default()
    router.GET("/students", getStudents)
    router.GET("/students/:roll_no", getStudent)
    router.POST("/students", createStudent)
    router.PUT("/students/:roll_no", updateStudent)
    router.DELETE("/students/:roll_no", deleteStudent)
    router.GET("/health", func(c *gin.Context) {
        c.String(http.StatusOK, "Healthy")
    })
    log.Println("Starting server on port 8084...")
    listener, err := net.Listen("tcp4", ":8084")
    if err != nil {
        log.Fatalf("Error starting server: %v", err)
    }
    if err := router.RunListener(listener); err != nil {
        log.Fatalf("Error starting server: %v", err)
    }
}