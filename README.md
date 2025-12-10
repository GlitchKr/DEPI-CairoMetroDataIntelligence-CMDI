# 🚇 Cairo Metro Data Intelligence (CMDI)

<div align="center">

![Cairo Metro](https://img.shields.io/badge/Cairo_Metro-2024-red?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3.8+-blue?style=for-the-badge&logo=python)
![SQL Server](https://img.shields.io/badge/SQL_Server-2019+-orange?style=for-the-badge&logo=microsoft-sql-server)
![Power BI](https://img.shields.io/badge/Power_BI-Latest-yellow?style=for-the-badge&logo=power-bi)

**End-to-end business intelligence solution for Cairo Metro operations**

</div>

---

## 📋 Overview

A comprehensive data warehouse analyzing Cairo Metro's 2024 operations using **Star Schema** architecture. Covers 366 days of passenger traffic, revenue, service quality, and weather impact across 80 stations and 3 metro lines.

### Key Features

- **2+ Million Records** - Complete year of operational data
- **40+ SQL Queries** - Pre-built analytics across 7 domains
- **Interactive Dashboard** - 5-page Power BI report
- **Egyptian Context** - Ramadan, holidays, and weather patterns

---

## 🏗️ Architecture

### Star Schema

```
         dim_time
             │
             ↓
    fact_passenger_counts  ← dim_station
             │
             ├─────────► dim_pricing
             ↓
    fact_od_trips
             │
             ↓
    fact_service_events
             │
             ↓
         dim_weather
```

### Tables

| Type | Table | Records | Description |
|------|-------|---------|-------------|
| **Dimension** | dim_time | 8,784 | Time dimension with holidays, seasons |
| **Dimension** | dim_station | 80 | Metro stations with GPS, characteristics |
| **Dimension** | dim_weather | 8,784 | Hourly temperature and conditions |
| **Dimension** | dim_pricing | 7 | Pricing zones (EGP 8-20) |
| **Fact** | fact_passenger_counts | ~700K | Hourly passenger counts per station |
| **Fact** | fact_od_trips | ~1.3M | Origin-destination trips with revenue |
| **Fact** | fact_service_events | 800 | Service disruptions and maintenance |

---

## 📊 Key Statistics

```
🚇 Network:          80 stations (3 lines + 4 transfers)
👥 Passengers:       200M+ annually / 550K+ daily
💰 Revenue:          EGP 2B+ annually
⚠️ Service Events:   800 disruptions
📅 Coverage:         Full year 2024 (366 days)
```

---

## 🚀 Quick Start

### 1. Install Requirements

```bash
git clone https://github.com/GlitchKr/DEPI-CairoMetroDataIntelligence-CMDI.git
cd DEPI-CairoMetroDataIntelligence-CMDI
pip install pandas numpy
```

### 2. Generate Data

```bash
python "Generate Data.py"
```

### 3. Create Database

```sql
-- Run in SQL Server Management Studio
sqlcmd -S localhost -i "Schema_Create.sql"
```

### 4. Import Data

Use SQL Server Import Wizard or BULK INSERT:

```sql
BULK INSERT dim_time
FROM 'path\to\dim_time.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');
-- Repeat for all 7 tables
```

### 5. Open Dashboard

Open `Cairo_Metro_Dashboard.pbix` in Power BI Desktop and update connection string.

---

## 📊 Power BI Dashboard

5 interactive pages:

1. **Overview** - KPIs, trends, top stations
2. **Passenger & Trips** - Traffic patterns, peak hours, heatmaps
3. **Revenue & Ticketing** - Financial performance, pricing analysis
4. **Service Quality** - Disruptions, reliability scores
5. **Weather** - Temperature impact, seasonal patterns

---

## 🔍 SQL Analysis

40+ queries organized into 7 sections:

| Section | Queries | Focus |
|---------|---------|-------|
| **Passenger Traffic** | 5 | Peak hours, trends, busy stations |
| **Ramadan & Events** | 5 | Holiday impact, Ramadan patterns |
| **Revenue** | 5 | Financial performance, pricing |
| **Origin-Destination** | 5 | Popular routes, travel patterns |
| **Service Quality** | 6 | Disruptions, reliability |
| **Weather Impact** | 4 | Temperature correlation |
| **Advanced Insights** | 5 | Multi-dimensional analysis |

**Example:**

```sql
-- Top 10 Busiest Stations
SELECT TOP 10
    s.station_name,
    SUM(f.passenger_count) as total_passengers
FROM fact_passenger_counts f
JOIN dim_station s ON f.station_id = s.station_id
GROUP BY s.station_name
ORDER BY total_passengers DESC;
```

---

## 📁 Project Structure

```
DEPI-CairoMetroDataIntelligence-CMDI/
│
├── data/                    # Generated CSV files
├── sql/
│   ├── Schema_Create.sql    # Database schema
│   └── CMDI - SQL Analysis.sql
├── python/
│   └── Generate Data.py     # Data generation
└── powerbi/
    └── Cairo_Metro_Dashboard.pbix
```

---

## 🎯 Key Insights

### Operational
- **Peak Hours:** 7-8 AM and 5-6 PM (3.5x normal traffic)
- **Ramadan:** 30% decrease during fasting, 40% increase after Iftar
- **Weekend:** 35% lower ridership

### Financial
- **Revenue Concentration:** 60% from business district routes
- **Best Pricing:** Zone 2 (10-16 stations) highest margin
- **Peak Revenue:** Evening peak generates 25% more

### Service Quality
- **Problem Concentration:** 20% of stations = 60% of events
- **Summer Issues:** 35% increase in technical failures (July-August)
- **Top Issue:** Signal problems (25% of all events)

---

## 💻 Technology Stack

- **Data Generation:** Python (Pandas, NumPy)
- **Database:** SQL Server 2019+ (Star Schema)
- **Visualization:** Power BI Desktop, Python (Matplotlib, Seaborn, Folium)
- **Analysis:** T-SQL (40+ queries)

---

## 👥 Team

Developed as part of the **DEPI (Digital Egypt Pioneers Initiative)** program.

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 📧 Contact

- **GitHub Issues:** [Create an issue](https://github.com/GlitchKr/DEPI-CairoMetroDataIntelligence-CMDI/issues)
- **Email:** your.email@example.com

---

<div align="center">

**⭐ Star this repo if you find it helpful!**

Made with ❤️ for the Cairo Metro Community

</div>
