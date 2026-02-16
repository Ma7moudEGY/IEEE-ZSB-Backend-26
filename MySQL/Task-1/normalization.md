# Database Normalization Guide
---

## What is Database Normalization?

Database normalization is a systematic approach to organizing data in a relational database. This process transforms poorly structured tables into multiple, related tables that eliminate redundancy and improve data integrity.

The goal is to create a database where:
- Each piece of information exists in only one place
- Data relationships are clearly defined
- The primary key uniquely identifies each record

---

## Understanding Functional Dependencies

Functional dependencies describe how attributes in a table relate to each other. When we say "X determines Y" (written as X → Y), it means:
- For every unique value of X, there's exactly one corresponding value of Y
- Attribute Y is functionally dependent on attribute X

In unnormalized databases, we encounter three dependency types:

1. **Complete Functional Dependency**: Attributes depend on the entire primary key
2. **Partial Functional Dependency**: Attributes depend on only part of a composite primary key
3. **Transitive Functional Dependency**: Non-key attributes depend on other non-key attributes

---

## The Normalization Process

Normalization progresses through different normal forms:
- **0NF (Unnormalized)**: Contains repeating groups and multivalued attributes
- **1NF**: Eliminates repeating groups and ensures atomic values
- **2NF**: Removes partial dependencies from 1NF
- **3NF**: Eliminates transitive dependencies from 2NF

---

# Practical Normalization Example

## Original Unnormalized Table: Academic_Records

| Student_Name | Student_Phone | Student_Address | Course_Title | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
|--------------|---------------|----------------|-------------|----------------|----------------|--------------|-------|
|              |               |                |             |                |                |              |       |

**Primary Key:** Composite key `(Student_Name, Course_Title)`

---

## Achieving First Normal Form (1NF)

**Problem:** Multiple phone numbers for students create repeating groups
**Solution:** Extract phone numbers into a separate table

### Resulting 1NF Structure:

**Academic_Records**
| Student_Name | Student_Address | Course_Title | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
|--------------|----------------|-------------|----------------|----------------|--------------|-------|
|              |                |             |                |                |              |       |

**Student_Phone_Numbers**
| Student_Name | Phone_Number |
|--------------|-------------|
|              |             |

*Each row now contains atomic values with no repeating groups*

---

## Moving to Second Normal Form (2NF)

**Problem:** Student address depends only on student name, not the full composite key
**Solution:** Create a dedicated student information table

### Resulting 2NF Structure:

**Course_Enrollment**
| Student_Name | Course_Title | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
|--------------|-------------|----------------|----------------|--------------|-------|
|              |             |                |                |              |       |

**Student_Details**
| Student_Name | City | Street | Postal_Code |
|--------------|------|--------|--------------|
|              |      |        |             |

**Student_Phone_Numbers**
| Student_Name | Phone_Number |
|--------------|-------------|
|              |             |

*Partial dependencies eliminated*

---

## Achieving Third Normal Form (3NF)

**Problems Identified:**
- Instructor department depends on instructor name (not primary key)
- Department building depends on department name (transitive dependency)

**Solution:** Create separate tables for instructor and department information

### Final 3NF Structure:

**Course_Enrollment**
| Student_Name (PK) | Course_Title (PK) | Instructor_Name (FK) | Grade |
|------------------|------------------|--------------------|-------|
|                  |                  |                    |       |

**Instructor_Information**
| Instructor_Name (PK) | Department_Name (FK) |
|---------------------|---------------------|
|                     |                     |

**Department_Details**
| Department_Name (PK) | Building_Location |
|---------------------|------------------|
|                     |                  |

**Student_Details**
| Student_Name (PK, FK) | City | Street | Postal_Code |
|-----------------------|------|--------|--------------|
|                       |      |        |             |

**Student_Phone_Numbers**
| Student_Name (PK, FK) | Phone_Number |
|-----------------------|-------------|
|                       |             |

*All transitive dependencies removed - database is now in 3NF*