# Server Outage Incident report
> By Onyero Chimezie Joshua

![](https://t3.ftcdn.net/jpg/04/92/09/72/240_F_492097246_yagE8x9Uk8M9IekPy7GBuE0x1Uoa7esD.jpg)

9th of June 2023, we experienced database replication lag misconfiguration, which resulted in our client's inability to use our services and we sincerely apologize for the financial loss our clients have incurred during this period.

## Issue Summary
![](https://www.cienotes.com/wp-content/uploads/2019/07/summaryblackboard.jpg)

On the 9th of June 2023 (14:00 WAT), we experienced database replication lag misconfiguration which lasted for two hours. This caused a significant delay in data synchronization between the primary and replica databases. This had a __100% impact__ on their business as they were unable to access our services.
The root cause was a misconfigured replication lag setting, set to 1 hour instead of 1 minute.

## Timeline (all time in GMT + 1)
![](https://www.ncbar.org/wp-content/uploads/2022/02/Timeline-Visual-300x145.png)

| Timeline | Incident                                                                                         |
| -------- | -------------------------------------------------------------------------------------------------|
| 13:55    | Monitoring alert triggers for database latency (alert threshold: 500ms, actual latency: 1500ms). |
| 14:00    | The engineer noticed an error rate spike (500 errors/min) and investigated.                      |
| 14:15    | Initial assumption: network connectivity issue between app and database servers.                 |
|          | Investigation: Checked network logs, ping tests, and traceroutes; all clear.                     |
| 14:30    | Investigation shifts to the database team.                                                       |
|          | Assumption: database version issue (recent upgrade to v12.1).                                    |
|          | Investigation: checked database logs, and version compatibility; all clear.                      |
| 14:45    | Misleading path: suspected database version issue.                                               |
| 14:45    | Investigation: spent 20 minutes reviewing version release notes and testing downgrade.           |
| 15:00    | Escalated to senior engineer (DB expert).                                                        |
|           | Fresh perspective: reviewed replication settings and noticed misconfiguration.                   |
| 15:20    | Root cause identified: misconfigured replication lag (set to 1hr instead of 1min).               |
| 15:30    | Fix applied: adjusted replication lag settings to 1 min.                                         |
| 15:45    | Verification and testing: monitored database performance and error rates.                        |
| 16:00    | Issue resolved.                                                                                  |

## Root Cause and Resolution
![](https://blog.systemsengineering.com/hs-fs/hubfs/blog-files/Root%20Cause.jpg?width=600&name=Root%20Cause.jpg)

The misconfigured database replication lag caused a significant delay in data synchronization between primary and replica databases. This led to errors and slow performance as the app attempted to access stale data. 
The fix involved adjusting the replication lag settings to ensure timely data synchronization.

## Corrective and Preventative Measures
![](https://cdn-ccchn.nitrocdn.com/eoxXytShChgscESECFYcqdYPaOaOGMwn/assets/images/optimized/rev-fbc0c0e/wp-content/uploads/2021/06/prevent-incidents.png)

-Improve database monitoring and alerting:
    Adjust alert thresholds for latency and error rates.
    Add monitoring for replication lag and data synchronization.
    
-Implement automated replication lag checks:
    Schedule daily checks for replication lag settings.
    Alert the DB team of any discrepancies.
    
-Schedule regular database performance reviews:
    Bi-weekly reviews of database performance and error rates.
    Identify and address potential issues before they become incidents.
    
-Add documentation on replication lag best practices:
    Update database setup guide with replication lag settings.
    Include troubleshooting steps for replication lag issues.

## TODOs
-Patch database servers with the latest updates (v12.2).
-Add memory monitoring to database servers.
-Review and refine database replication settings.
-Document the incident and share it with the team (this postmortem).

This postmortem highlights the importance of thorough investigation, collaboration, and knowledge sharing in resolving complex issues. By sharing our experience, we aim to enhance our collective knowledge and improve our systems' reliability.
