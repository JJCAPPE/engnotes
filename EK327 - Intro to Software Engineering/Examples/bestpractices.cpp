#include <iostream>

// SINGLE RESPONSIBILITY PRINCIPLE
// Each function, class, file should do one thing and do it well

//only does one thing too
void processLine(const char* line) {
    if (strstr(line, "ERROR")) {
        printf("Log contains an error: %s", line);
    }
}

//only does one thing
char** readFile(const char* filename, int* lineCount){
FILE* file = fopen(filename, "r");
if (file == NULL) {
    printf("Error: Could not open file.\n");
    *lineCount = 0;
    return NULL;
}
char** lines = NULL;
char buffer[256];
while (fgets(buffer, sizeof(buffer), file)) {
   // Stuff
    }
return lines;
}

//puts it together
int main1() {
    int lineCount = 0;
    char** lines = readFile("logfile.txt", &lineCount);
    for (int lineIndex = 0; lineIndex < lineCount; lineIndex++) {
        processLine(lines[lineIndex]);
    }
    return 0;
}

// ENCAPSULATION
// better to encapsulate details of a common object
struct Student {
    int id;
    const char* name;
    float gpa;
};

void displayStudentInfo(Student student) {
    printf("Student ID: %d\n", student.id);
    printf("Name: %s\n", student.name);
    printf("GPA: %.2f\n", student.gpa);
}



