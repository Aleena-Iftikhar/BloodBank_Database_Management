# 🩸 Blood Bank Management System

A complete **Blood Bank Database Management System** built with **MySQL**, designed to manage blood donations, patients, hospitals, donors, and blood bank operations efficiently.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Database](#database)
- [Tables](#tables)
- [Stored Procedures](#stored-procedures)
- [How to Run](#how-to-run)
- [Requirements](#requirements)
- [Project Structure](#project-structure)

---

## 📌 Overview

This project is a relational database system for managing a **Blood Bank**. It tracks:

- Blood donations and blood groups in stock
- Patients and their blood requests
- Donors and their registration details
- Hospitals and their blood requirements
- Blood Bank branches managed by managers
- Registration teams and Technical analysts working in each blood bank

---

## 🗄️ Database

**Database Name:** `bloodBankDB`

---

## 🗂️ Tables

| # | Table Name | Description |
|---|-----------|-------------|
| 1 | `Manager` | Manages requests from hospitals |
| 2 | `Bloodbank` | Blood bank branches info |
| 3 | `Bloodbank_manager` | Links managers to blood banks |
| 4 | `Registration_teamm` | Teams that register donors and patients |
| 5 | `Technical_analyst137` | Analysts who examine donated blood |
| 6 | `Blood_donated` | Records of donated blood and blood groups |
| 7 | `Patient137` | Patient information and blood requirements |
| 8 | `BloodRequest` | Blood requests with amount and type |
| 9 | `PatientRequest` | Links patients to their blood requests |
| 10 | `Hospital` | Hospital information managed by managers |
| 11 | `Hospitalrequestt` | Blood requests made by hospitals |
| 12 | `BLoodreceived` | Records of blood received by patients |
| 13 | `Tecanalyst_blood` | Blood groups examined by each analyst |
| 14 | `Donor` | Donor personal and medical information |

---

## ⚙️ Stored Procedures

### Data Entry Procedures (INSERT / UPDATE / DELETE / SELECT)

| Procedure | Table |
|-----------|-------|
| `Manager37_PROCE4` | Manager |
| `BB73_PROCE4` | Bloodbank |
| `Register_PROCE4` | Registration_teamm |
| `TA37_PROCE4` | Technical_analyst137 |
| `PT37_PROCE4` | Patient137 |
| `Hosp_PROCE4` | Hospital |
| `Do_PROCE4` | Donor |

> Each procedure accepts a `p_type` parameter: `'INSERT'`, `'SELECT'`, `'UPDATE'`, or `'DELETE'`

### Query Procedures

| # | Procedure | Description |
|---|-----------|-------------|
| 1 | `Blood_typees` | Shows which blood groups a given type can donate to |
| 2 | `List_Donor3` | Lists healthy donors of a specific blood group |
| 3 | `STOCK` | Shows current blood stock quantity by group |
| 4 | `Queryy1` | Donors filtered by blood type and age |
| 5 | `Queryy2` | Donors filtered by city and name pattern |
| 6 | `Queryy3` | Donors aged between a given range with registration team info |
| 7 | `Quer4` | Donors and patients with a specific blood group |
| 8 | `Querry5` | Blood banks where a specific blood group is available |
| 9 | `Queryy6` | Donors registered within a date range |
| 10 | `Queryr11` | Patients who received a specific number of blood bags |
| 11 | `Querryy8` | Managers and blood banks filtered by manager age |
| 12 | `Querry9` | Registration teams with members below a given count |
| 13 | `Querryy9` | Managers storing a specific blood group |
| 14 | `Qu13` | Total number of patient blood requests |
| 15 | `Querr14` | Blood bags requested by each hospital |
| 16 | `Que15` | Total blood requests count |
| 17 | `Que16` | Full blood bank details with staff info |
| 18 | `Que17` | Specific blood bank details by ID |
| 19 | `Que18` | Managers and their managed hospitals |
| 20 | `Quey19` | Managers with their donated blood (LEFT JOIN) |
| 21 | `Quey20` | Patients and their managing managers |
| 22 | `Queryy22` | Blood groups analyzed by each technical analyst |
| 23 | `Qurry23` | Donors filtered by phone number range |

---

## ▶️ How to Run

### Using MySQL Workbench

1. Open **MySQL Workbench**
2. Go to `File` → `Open SQL Script`
3. Select the `bloodbank_mysql.sql` file
4. Press **`Ctrl + Shift + Enter`** to run the entire script
5. Refresh the Schemas panel — `bloodBankDB` will appear ✅

### Using Command Line

```bash
mysql -u root -p < bloodbank_mysql.sql
```

---

## 🛠️ Requirements

- MySQL 8.0 or above
- MySQL Workbench (optional, for GUI)

---

## 📁 Project Structure

```
bloodBankDB/
│
├── bloodbank_mysql.sql     # Complete database script (tables + data + procedures)
└── README.md               # Project documentation
```

---

## 👨‍💻 Author

> Database Term Project  
> Tool: MySQL Workbench  
> Language: SQL (MySQL)

---

