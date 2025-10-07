# University Management System 🎓

A comprehensive database system for managing university operations.

## Overview

This database system streamlines academic record-keeping by efficiently managing students, faculty, courses, enrollments, and grades. Built as the final project for CS50's Introduction to Databases with SQL.

## Features

- 👨‍🎓 Student information management
- 👨‍🏫 Faculty records and assignments
- 📚 Course catalog and offerings
- 📝 Enrollment tracking
- 🎯 Grade management
- 🔍 Query system for academic records

## Database Structure

The system includes the following key components:

- **Students** - Student profiles and personal information
- **Faculty** - Faculty members and their details
- **Courses** - Course catalog with descriptions
- **Enrollments** - Student-course relationships
- **Grades** - Academic performance records

## Files

```
├── schema.sql       # Database schema definitions
├── queries.sql      # Sample queries
├── university.db    # SQLite database file
├── diagram.png      # ER diagram
└── DESIGN.md        # Design documentation
```

## Setup

### Prerequisites

- SQLite3

### Installation

```bash
# Clone repository
git clone <repository-url>
cd CS50SQL

# Create database
sqlite3 university.db < schema.sql
```

## Usage

### Basic Queries

```sql
-- View all students
SELECT * FROM students;

-- View course enrollments
SELECT * FROM enrollments;

-- Check student grades
SELECT * FROM grades WHERE student_id = 1;
```

### Run Custom Queries

```bash
sqlite3 university.db < queries.sql
```

## Design Decisions

See `DESIGN.md` for detailed information about:
- Database normalization
- Table relationships
- Indexing strategy
- Query optimization

## Example Use Cases

- Track student enrollment across semesters
- Manage faculty course assignments
- Generate grade reports
- Monitor course capacity
- Query student academic history

## Future Enhancements

- [ ] Add department management
- [ ] Implement attendance tracking
- [ ] Add financial records
- [ ] Create API endpoints
- [ ] Build web interface

## Author

Deephang Thegim

## License

© 2025 Deephang Thegim. All rights reserved.

This project was created for CS50's Introduction to Databases with SQL. You may use, modify, and share this project with attribution. Commercial use requires permission. Academic integrity applies.
