
# SQL Replication via I/O Hooks and Primary Key

**If some of your ISAM files do not have a unique primary keys then refer to [SqlReplicationIoHooksAddKey](https://github.com/SteveIves/SqlReplicationIoHooksAddKey) instead.**

This repository contains an example of how to modify a Synergy application that stores its data in ISAM files to replicate that ISAM data to a SQL Server database in near-to real-time.

To facilitate code generation it is a requirement that the data structures (including key definitions) and files that are to be replicated are acurately described in a Synergy repository. Once your repository definitions are complete, CodeGen is used to generate various types of code relating to the data structures and files that are to be replicated.

The original application is then modified with the addition of I/O hooks objects (which were code generated) to any channels that are opened for update to files that are to be replicated. If your application already uses a single subroutine to open data files then this change will be the addition of just a few lines of code in that subroutine. The code in the I/O hooks class is responsible for tracking and recording the records that change in the underlying ISAM files.

Once this change information is being recorded a single process called the "replicator" is then used to mirror those changes to matching tables in a SQL Server database.

There are several advantages to taking this kind of approach, some of the major ones being:

* You don't need to totally re-design your Synergy applications to store the actual application data in SQL Server. To do this properly would be a very major re-write of any application.
* You don't put the overhead of writing the data to both ISAM and SQL Server into your actual user applications, the performance overhead of which can be very significant.
* You don't make your user applications directly dependent on the database being started.  If the database, or replication server are not started then the transactions will simply build up in the log file until such time as they are started.

Following the code in this examples will mean that you can implement data replication with only minimal changes to the original Synergy applications. This is not a project that will happen overnight. In order to be successful with this type of project, the major requirements are:

* Each of the ISAM files that you wish to replicate to the database musthave a unique primary key.
* You will need to add a couple of lines of code after each OPEN statement that opens your data files for update.

## Requirements

This example was originally created using Synergy/DE V10.3.3 on a Windows system, and should work on any higher version. In theory the software should also work on UNIX and OpenVMS, although some environmental setup would be required.  The database used during testing was Microsoft SQL Server 2014 and the code should work with any later version of SQL Server, and some earlier versions also.

## Development Environment

Use workbench and open the Workspace SQLReplicaitonIoHooksPrimaryKey.vpw This workspace contains three projects, as follows:

### application.vpj

Contains a UI Toolkit application that includes an employee maintenance function. The replicator program can be started, stopped and controlled via menu items in the application.

### library.vpj

Contains subroutines and functions that are used both by the UI Toolkit application, and the replicator program. Note that the main code used to interact with ISAM files (EmployeeIO.dbl) and the relational database (EmployeeSqlIO.dbl) are in this library. These files (and others) were code-generated by using the CodeGen utility.

### replicator.vpj

Contains the replicator program.

## Setup

If you wish to actually configure and execute this demo you will need:

* Synergy/DE (V10.3.3 or higher) Professional Series Workbench on Windows
* A SQL Server 2014 database (or higher) and at least one Synergy/DE SQL connection license available.  If you wish to avoid editing the supplied example code then use a SQL Server database on the same computer that you intend to run the Synergy code on, and make sure that database is configured to accept Windows Authentication.  If you do not use a local database then you will need change the value of the REPLICATOR_DATABASE environment variable that is defined in the project properties of the application.vpj project.
* Create a new SQL Server database and make sure that the account that you will be using to connect to the database server has access to the new database. If you wish to avoid editing the supplied example code then name the database "SynergyReplication". If you do not use this default database name then you will need to change the value of the REPLICATOR_DATABASE environment variable that is defined in the project properties of the application.vpj project.
* Start Workbench and open the workspace called SQLReplicaitonIoHooksPrimaryKey.vpw. Use the "Project > Open Workspace..." menu option to do this.  Make sure you can see the "Projects" window.  If it is not active then make it active, if it is not displayed then display it by selecting "View -> Toolbars" from the menu and checking the "Projects" option.

## Building the Code in Workbench

* Right-click on the library.vpj project and select "Set Active Project"
* From the main menu, select "Build > Load Data Files" to create the ISAM data files.
* From the main menu, select "Build > Import Schema to Repository" to load the repository schema into repository ISAM files.
* From the main menu, select "Build > Build" to build the library project
* Right-click on the replicator.vpj project and select "Set Active Project"
* From the main menu select "Build > Build" to build the replicator program.
* Right-click on the application.vpj project and select "Set Active Project"
* From the main menu select "Build > Build" to build the main application
* Right-click on the application.vpj project and select "Compile Scripts Setup..."
* Change the "Window Library" file spec so that the path to the EXE\tkapp.ism file is correct for your system, then click the OK button.
* Right-click on the application.vpj project and select "Compile Scripts" to compile the UI Toolkit window library (creates EXE\tkapp.ism)

## Preparing the Database

The code in this example is configured for use with a local default instance of a recent version of Microsoft SQL Server (Express edition is OK) that is configured to accept Windows authentication. The only database preparation that is necessary is to create an empty database named "SqlReplicationPrimaryKey".

If your SQL Server database is not local, or does not accept Windows authentication, you will need to change the value of the REPLICATOR_DATABASE environment variable that is defined in the project properties of the application.vpj project. Refer to the section on configuring connect strings in the Synergy/DE SQL Connection API manual for more details.

## Running the demo

In order to see the replication happenning use SQL Server Management Studio to connect to the SqlReplicationPrimaryKey database and display the list of tables in the database - there aren't any at the moment.  Run the Synergy client application by ensuring that application.vpj is the current project, and then selecting "Build > Execute" from the Workbench menu.

Start the replicator process by selecting select "Replicator -> Start Replicator" from the application menu. You should see some messages, including:

        Initializing SQL Connection
        Connecting to database
        Ready to process instructions...

You should see the replicator start checking for things to do every 5 seconds.

Next pick "Applications -> Employee Maintenance", then cick on the search button to show a list of all of the employees in the ISAM file.  Double click an employee to edit it, then change something and click OK.

This will record an update operation in the replication servers transaction log. Within five seconds it should pick up the entry, realize there is an update to the database, and try to replicate the change.  The first time this happens it will realize that the EMPLOYEE table doesn't exist in the database as yet, so it should create the table, and then initiate a full load of the table from the ISAM file.

Check Management studio, is the table and data there yet?  If not then you probably got error messages from the replicator and need to debug the environment.

From now on, as you create, amend and delete employee records, those changes should be replicated to the EMPLOYEE table in SQL server. The example replicator goes to sleep for five seconds if there is nothing to do, so you should see any changes within that time frame. If you are sitting looking at the table in Management studio however, the table is not automatically refreshed, you you'll have to refresh it manually each time you want to see a change.

The replicator process would generally be run as a Windows service or detached process, and can be controlled by putting "instructions" into it's ISAM file. There are various options on the "Replicator" menu to do this. For example, to stop the replicator, select "Replicator -> Stop Replicator".

Enjoy!

Author: Steve Ives, Synergex Professional Services Group (steve.ives@synergex.com)
