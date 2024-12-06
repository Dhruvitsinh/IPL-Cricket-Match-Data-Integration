use ipldata_etl


-------dim_Country

CREATE TABLE [ipl].[dim_Country] (
    [Country_Id] INT NOT NULL PRIMARY KEY,
    [Country_Name] VARCHAR(100) NULL
);
GO


------------[ipl].[dim_City]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_City] (
    [City_Id] INT NOT NULL PRIMARY KEY,
    [City_Name] VARCHAR(100) NULL,
    [Country_Id] INT NULL,
    FOREIGN KEY ([Country_Id]) REFERENCES [ipl].[dim_Country] ([Country_Id])
);
GO

------------[ipl].[dim_Venue]



USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Venue] (
    [Venue_Id] INT NOT NULL PRIMARY KEY,
    [Venue_Name] VARCHAR(100) NULL,
    [City_Id] INT NULL,
    FOREIGN KEY ([City_Id]) REFERENCES [ipl].[dim_City] ([City_Id])
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
GO


------------[ipl].[dim_Role]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Role] (
    [Role_Id] INT NOT NULL PRIMARY KEY,
    [Role_Desc] VARCHAR(100) NULL
);
GO

--------------- [ipl].[dim_Toss_Decision]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Toss_Decision] (
    [Toss_Id] INT NOT NULL PRIMARY KEY,
    [Toss_Name] VARCHAR(100) NULL
);
GO

------------ [ipl].[dim_Team]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Team] (
    [Team_Id] INT NOT NULL PRIMARY KEY,
    [Team_Name] VARCHAR(100) NULL
);
GO

-------------  [ipl].[dim_Batting_Style]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Batting_Style] (
    [Batting_Id] INT NOT NULL PRIMARY KEY,
    [Batting_hand] VARCHAR(100) NULL
);
GO

------------- [ipl].[dim_Bowling_Style]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Bowling_Style] (
    [Bowling_Id] INT NOT NULL PRIMARY KEY,
    [Bowling_skill] VARCHAR(100) NULL
);
GO

----------- [ipl].[dim_Extra_Type]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Extra_Type] (
    [Extra_Id] INT NOT NULL PRIMARY KEY,
    [Extra_Name] VARCHAR(100) NULL
);
GO

------------  [ipl].[dim_Player]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Player] (
    [Player_Id] INT NOT NULL PRIMARY KEY,
    [Player_Name] VARCHAR(100) NULL,
    [DOB] DATE NULL,
    [Batting_hand] INT NULL,
    [Bowling_skill] INT NULL,
    [Country_Name] INT NULL,
    FOREIGN KEY ([Batting_hand]) REFERENCES [ipl].[dim_Batting_Style] ([Batting_Id]),
    FOREIGN KEY ([Bowling_skill]) REFERENCES [ipl].[dim_Bowling_Style] ([Bowling_Id]),
    FOREIGN KEY ([Country_Name]) REFERENCES [ipl].[dim_Country] ([Country_Id])
);
GO


------------  [ipl].[dim_Outcome]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Outcome] (
    [Outcome_Id] INT NOT NULL PRIMARY KEY,
    [Outcome_Type] VARCHAR(100) NULL
);
GO


------------- [ipl].[dim_Out_Type]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Out_Type] (
    [Out_Id] INT NOT NULL PRIMARY KEY,
    [Out_Name] VARCHAR(100) NULL
);
GO


---------  [ipl].[dim_Win_By]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[dim_Win_By] (
    [Win_Id] INT NOT NULL PRIMARY KEY,
    [Win_Type] VARCHAR(100) NULL
);
GO


------------- [ipl].[fact_Season]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[fact_Season] (
    [Season_Id] INT NOT NULL PRIMARY KEY,
    [Man_of_the_Series] INT NULL,
    [Orange_Cap] INT NULL,
    [Purple_Cap] INT NULL,
    [Season_Year] INT NULL,
    FOREIGN KEY ([Man_of_the_Series]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Orange_Cap]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Purple_Cap]) REFERENCES [ipl].[dim_Player] ([Player_Id])
);
GO


------------- [ipl].[fact_Match]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[fact_Match] (
    [Match_Id] INT NOT NULL PRIMARY KEY,
    [Team_1] INT NULL,
    [Team_2] INT NULL,
    [Match_Date] DATE NULL,
    [Season_Id] INT NULL,
    [Venue_Id] INT NULL,
    [Toss_Winner] INT NULL,
    [Toss_Decide] INT NULL,
    [Win_Type] INT NULL,
    [Win_Margin] INT NULL,
    [Outcome_type] INT NULL,
    [Match_Winner] INT NULL,
    [Man_of_the_Match] INT NULL,
    FOREIGN KEY ([Outcome_type]) REFERENCES [ipl].[dim_Outcome] ([Outcome_Id]) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY ([Man_of_the_Match]) REFERENCES [ipl].[dim_Player] ([Player_Id]) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY ([Team_1]) REFERENCES [ipl].[dim_Team] ([Team_Id]),
    FOREIGN KEY ([Team_2]) REFERENCES [ipl].[dim_Team] ([Team_Id]),
    FOREIGN KEY ([Toss_Winner]) REFERENCES [ipl].[dim_Team] ([Team_Id]),
    FOREIGN KEY ([Match_Winner]) REFERENCES [ipl].[dim_Team] ([Team_Id]),
    FOREIGN KEY ([Toss_Decide]) REFERENCES [ipl].[dim_Toss_Decision] ([Toss_Id]) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY ([Win_Type]) REFERENCES [ipl].[dim_Win_By] ([Win_Id]) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY ([Season_Id]) REFERENCES [ipl].[fact_Season] ([Season_Id]) ON UPDATE CASCADE ON DELETE CASCADE
);
GO


--------------  [ipl].[fact_Player_Match]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[fact_Player_Match] (
    [Match_Id] INT NOT NULL,
    [Player_Id] INT NOT NULL,
    [Role_Id] INT NULL,
    [Team_Id] INT NULL,
    PRIMARY KEY ([Match_Id], [Player_Id]),
    FOREIGN KEY ([Player_Id]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Role_Id]) REFERENCES [ipl].[dim_Role] ([Role_Id]),
    FOREIGN KEY ([Team_Id]) REFERENCES [ipl].[dim_Team] ([Team_Id]),
    FOREIGN KEY ([Match_Id]) REFERENCES [ipl].[fact_Match] ([Match_Id])
);
GO


---------------  [ipl].[fact_Ball_by_Ball]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[fact_Ball_by_Ball] (
    [Match_Id] INT NOT NULL,
    [Over_Id] INT NULL,
    [Ball_Id] INT NULL,
    [Innings_No] INT NULL,
    [Team_Batting] INT NULL,
    [Team_Bowling] INT NULL,
    [Striker_Batting_Position] INT NULL,
    [Striker] INT NULL,
    [Non_Striker] INT NULL,
    [Bowler] INT NULL,
    PRIMARY KEY ([Match_Id], [Over_Id], [Ball_Id]),
    FOREIGN KEY ([Striker]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Non_Striker]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Bowler]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Team_Batting]) REFERENCES [ipl].[dim_Team] ([Team_Id]),
    FOREIGN KEY ([Team_Bowling]) REFERENCES [ipl].[dim_Team] ([Team_Id]),
    FOREIGN KEY ([Match_Id]) REFERENCES [ipl].[fact_Match] ([Match_Id])
);
GO


----------- [ipl].[fact_Batsman_Scored]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[fact_Batsman_Scored] (
    [Match_Id] INT NULL,
    [Over_Id] INT NULL,
    [Ball_Id] INT NULL,
    [Runs_Scored] INT NULL,
    [Innings_No] INT NULL,
    PRIMARY KEY ([Match_Id], [Over_Id], [Ball_Id]),
    FOREIGN KEY ([Match_Id]) REFERENCES [ipl].[fact_Match] ([Match_Id])
);
GO


--------------  [ipl].[fact_Extra_Runs]


USE [ipldata_etl];
GO

CREATE TABLE [ipl].[fact_Extra_Runs] (
    [Match_Id] INT NULL,
    [Over_Id] INT NULL,
    [Ball_Id] INT NULL,
    [Extra_Type_Id] INT NULL,
    [Extra_Runs] INT NULL,
    [Innings_No] INT NULL,
    PRIMARY KEY ([Match_Id], [Over_Id], [Ball_Id]),
    FOREIGN KEY ([Extra_Type_Id]) REFERENCES [ipl].[dim_Extra_Type] ([Extra_Id]),
    FOREIGN KEY ([Match_Id]) REFERENCES [ipl].[fact_Match] ([Match_Id])
);
GO

---------- [ipl].[fact_Wicket_Taken]

USE [ipldata_etl];
GO

CREATE TABLE [ipl].[fact_Wicket_Taken] (
    [Match_Id] INT NULL,
    [Over_Id] INT NULL,
    [Ball_Id] INT NULL,
    [Player_Out] INT NULL,
    [Kind_Out] INT NULL,
    [Fielders] INT NULL,
    [Innings_No] INT NULL,
    PRIMARY KEY ([Match_Id], [Over_Id], [Ball_Id]),
    FOREIGN KEY ([Player_Out]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Kind_Out]) REFERENCES [ipl].[dim_Out_Type] ([Out_Id]),
    FOREIGN KEY ([Fielders]) REFERENCES [ipl].[dim_Player] ([Player_Id]),
    FOREIGN KEY ([Match_Id]) REFERENCES [ipl].[fact_Match] ([Match_Id])
);
GO


