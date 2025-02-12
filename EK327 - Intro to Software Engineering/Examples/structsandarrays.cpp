#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

// association of a finite set of values
enum Semester
{
    FALL,
    SPRING
};

struct BUClass
{
    string name;
    int year;
    Semester semester;
};
// define an abstraction of an object
struct Student
{
    string firstName;
    string lastName;
    int graduationYear;
    float gpa;
    BUClass *classes[10]; // buclass is pointer so no copies are made for each class
    int classesSize =0;
};

int main2()
{
    BUClass cs = {"CS", 2023, FALL};
    Student ella = {"ella", "vator", 2027, 3.78, &cs};
    cout << ella.firstName << " " << ella.lastName << " will graduate in " << ella.graduationYear << "and is part of" << ella.classes[0]->name << " " << ella.classes[0]->year << " " << ella.classes[0]->semester << endl;
}

// MAKE UML

// Pass by reference or value

// Pass by reference in structs , use -> to access instead of .
void registerForClass(Student *student, BUClass buClass)
{
    student->classes[student->classesSize] = &buClass;
    student->classesSize++;
}
int main3()
{
    BUClass buClass = {"ec327", 2025, SPRING};
    Student ella = {"ella", "vator", 2027, 3.78};
    std::cout << "ella's current class: " << ella.classes[0]->name << std::endl; // null initially
    registerForClass(&ella, buClass);
    std::cout << "ella's current class: " << ella.classes[0]->name << std::endl;
    return 0;
}

// ARRAYS are a collection of elements of the same type, stored contiguously in memory, with fixed length

float randomFloatInRange(float min, float max)
{
    return min + static_cast<float>(rand()) / (static_cast<float>(RAND_MAX / (max - min)));
}

int main()
{
    srand(static_cast<unsigned int>(time(0)));
    Student students[2] = {{"ella", "vator", 2027, 3.78}, {"joe", "biden", 2023, 4.0}};
    return 0;
}

// arrays are passed by reference

void printArrayInfo(int array[])
{
    std::cout << sizeof(array) / sizeof(array[0]) << std::endl;
}
int main5()
{
    int finalGrades[] = {91, 83, 78, 84, 73};
    printArrayInfo(finalGrades); // will print 2 instead of 5 because it is passing a pointer to the first element, so always need to pass size with array
}

//example usage

void probabilisicallyRegisterForClass(Student *student, BUClass *buClass, float probability)
{
    if (randomFloatInRange(0.0, 1.0) <= probability)
    {
        student->classes[student->classesSize] = buClass;
        student->classesSize++;
    }
}
void printClassesInfo(BUClass *classes[], int classesSize)
{
    for (int index = 0; index < classesSize; index++)
    {
        std::cout << classes[index]->name << std::endl;
    }
}

BUClass ec327 = {"EC327", 2025, SPRING};
BUClass ec330 = {"EC330", 2025, SPRING};
BUClass ec400 = {"EC400", 2025, SPRING};
BUClass ec440 = {"EC440", 2025, SPRING};
BUClass ec527 = {"EC527", 2025, SPRING};

int main()
{
    Student students[80];
    for (int index = 0; index < 80; index++)
    {
        students[index] =
            {
                "first" + std::to_string(index), "last" + std::to_string(index),
                2027, randomFloatInRange(2.0, 4.0)};
        probabilisicallyRegisterForClass(&students[index], &ec327, 1.0);
        probabilisicallyRegisterForClass(&students[index], &ec330, 0.4);
        probabilisicallyRegisterForClass(&students[index], &ec400, 0.3);
        probabilisicallyRegisterForClass(&students[index], &ec440, 0.2);
        probabilisicallyRegisterForClass(&students[index], &ec527, 0.1);
    }
    for (int index = 0; index < 80; index++)
    {
        if (students[index].classesSize >= 4)
        {
            std::cout << "student registered for at least 4 classes: " << students[index].lastName << std::endl;
            printClassesInfo(students[index].classes, students[index].classesSize);
        }
    }
}