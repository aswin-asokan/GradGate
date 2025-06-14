# 🎓 GradGate

**Version:** 1.5.0  
**Platforms Supported:** Android (Tablet), Linux  
**Database:** SQLite (via `sqflite`)

## 📖 About

GradGate is a lightweight and powerful placement management simulation app built with Flutter. It helps simulate and manage a simplified version of a college placement system using a local SQLite database. GradGate is designed to mimic the working of a real-world placement system. It supports functionality for students, employers, and colleges—providing a seamless experience for job applications, employer listings, and candidate management, all handled locally without a remote backend.

> 🔔 **Note**: This app is a simulation tool and runs completely on a local database. No internet or server backend is used.

## 🚀 Key Features

- 👩‍🎓 **Student Module**

  - View and apply for jobs based on department eligibility.
  - Receive application status and employer replies.
  - Profile with editable "About Me" section using rich text.

- 🏢 **Employer Module**

  - Post jobs with filters by eligible departments.
  - View applicant lists and update application statuses (selected, waiting, rejected).
  - View student profiles with resume-style information.

- 🏫 **College Module**

  - Register and manage student entries.
  - Track placement analytics like total applicants, selected students, average salary, etc.

- 🔐 **Authentication System**

  - Separate login for students, colleges, and employers.

- 📊 **Analytics**

  - Student, college and company dashboards showing job and application metrics.

- 💾 **Local Persistence**
  - Entire system functions offline using `sqflite`.

---

## 🛠️ Table Schema Overview

### `students`

| Column     | Type    | Description          |
| ---------- | ------- | -------------------- |
| id         | INTEGER | Primary key          |
| name       | TEXT    | Student name         |
| email      | TEXT    | Unique email         |
| phone      | TEXT    | Contact number       |
| department | TEXT    | E.g., CSE, AIML, CE  |
| college    | TEXT    | College name         |
| about      | TEXT    | JSON rich text       |
| link       | TEXT    | Profile picture path |

---

### `employers`

| Column   | Type    | Description        |
| -------- | ------- | ------------------ |
| id       | INTEGER | Primary key        |
| name     | TEXT    | Company name       |
| email    | TEXT    | Unique email       |
| location | TEXT    | Company location   |
| link     | TEXT    | Logo/profile image |

---

### `jobs`

| Column      | Type    | Description                                  |
| ----------- | ------- | -------------------------------------------- |
| id          | INTEGER | Primary key                                  |
| employer_id | INTEGER | FK to `employers(id)`                        |
| title       | TEXT    | Job title                                    |
| description | TEXT    | Job description                              |
| salary      | TEXT    | Offered salary (stored as TEXT)              |
| branches    | TEXT    | Comma-separated dept list (e.g., `CSE,AIML`) |
| status      | TEXT    | `active`, `closed`, `in progress`            |
| date        | TEXT    | Date posted                                  |
| type        | TEXT    | Job type (Intern, Full-time)                 |

---

### `applied`

| Column     | Type    | Description                           |
| ---------- | ------- | ------------------------------------- |
| id         | INTEGER | Primary key                           |
| job_id     | INTEGER | FK to `jobs(id)`                      |
| student_id | INTEGER | FK to `students(id)`                  |
| status     | TEXT    | `waiting`, `selected`, `rejected`     |
| reply      | TEXT    | `accepted`, `declined` (from student) |

---

## 🧾 Changelog

### v1.5.0

- Switched backend from MySQL/PHP to local SQLite using `sqflite`.
- Added support for offline functionality and improved performance.
- Platform-specific enhancements for Android (tablet) and Linux.

### v1.0.0

- Initial release using MySQL and PHP backend.

---

## 📎 Screenshots

| <img src="https://github.com/user-attachments/assets/49edaa51-70a9-43e2-b7e1-6eeece11c13a" alt="login"/>               | <img src="https://github.com/user-attachments/assets/9aba4bb0-92df-4740-9374-5e55db2f25b8" alt="register"/>             |
| ---------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/user-attachments/assets/9795e61f-e3e7-40da-90b3-3f83f33ded8a" alt="employer-reg"/>        | <img src="https://github.com/user-attachments/assets/29d00d01-ad2b-4966-81af-3c6ca6d508e6" alt="employer-reg2"/>        |
| <img src="https://github.com/user-attachments/assets/acfafcf0-ae39-46f1-b442-9bcfac77d9d1" alt="employer-profile" />   | <img src="https://github.com/user-attachments/assets/2c4cdbce-b6b5-432f-be64-3f4897adaae4" alt="employer-post-job-1"/>  |
| <img src="https://github.com/user-attachments/assets/2c4cdbce-b6b5-432f-be64-3f4897adaae4" alt="employer-post-job-1"/> | <img src="https://github.com/user-attachments/assets/2c4cdbce-b6b5-432f-be64-3f4897adaae4" alt="employer-post-job-1"/>  |
| <img src="https://github.com/user-attachments/assets/a5bb4aca-b38b-4ffa-9348-0fe97ee1ad01" alt="employer-post-job-2"/> | <img src="https://github.com/user-attachments/assets/62d636ea-eff7-4e4b-bf30-b1254178d865" alt="employer-job-view"/>    |
| <img src="https://github.com/user-attachments/assets/ed129b96-45bd-451a-a65d-29b5c3055d61" alt="employer-dashboard"/>  | <img src="https://github.com/user-attachments/assets/40868353-2b75-4997-87d8-76d803fb6c41" alt="student-job-search"/>   |
| <img src="https://github.com/user-attachments/assets/16ea23a5-adc5-4180-8300-d1fb41074d5a" alt="student-job-alert"/>   | <img src="https://github.com/user-attachments/assets/07996a8f-2672-4ff1-8a6b-88187227c8d3" alt="student-dashboard"/>    |
| <img src="https://github.com/user-attachments/assets/7942ced2-bf9b-4667-8d8c-aa59c11c1e46" alt="student-settings"/>    | <img src="https://github.com/user-attachments/assets/267941a0-6d50-4761-a0b6-be0d554d5ab2" alt="student-reg1"/>         |
| <img src="https://github.com/user-attachments/assets/e81fdcdf-a673-4edf-a9f0-7298af59efc9" alt="student-reg2"/>        | <img src="https://github.com/user-attachments/assets/e4014066-d979-4f8d-a192-bc3e74d1c542" alt="student-profile"/>      |
| <img src="https://github.com/user-attachments/assets/aef54e35-0f93-4385-9d73-34adb1c793ad" alt="view-job"/>            | <img src="https://github.com/user-attachments/assets/f82e7bd3-0064-4356-94a8-2b82b6c625dd" alt="college-view-student"/> |
| <img src="https://github.com/user-attachments/assets/9f1a55e2-8c6b-40ca-9b5f-c6dd0b577367" alt="college-settings"/>    | <img src="https://github.com/user-attachments/assets/f443e6aa-86f0-40dc-8e90-bfa270d13933" alt="college-reg"/>          |
| <img src="https://github.com/user-attachments/assets/46388f71-fda8-481f-800b-410f4872a25c" alt="college-dashboard"/>   |                                                                                                                         |

## 🔖 References:

[Job portal UI by Ronas IT | UI/UX Team](https://dribbble.com/shots/21587286-Job-Search-Platform)

## 📬 Feedback or Contributions

Open an issue or fork the repo to contribute ideas or fixes.

---

### 🧪 Simulation Mode

This app is intended to **simulate** how a real-world placement management system works in a fully **offline environment** for demonstration and educational purposes.

---
