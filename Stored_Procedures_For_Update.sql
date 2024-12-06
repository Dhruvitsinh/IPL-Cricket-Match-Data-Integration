--------stored procedure


-------1) [ipl].[dim_Country]---------------------------------

CREATE PROCEDURE spUpdateiplCountryById
@country_id INT,                -- Primary key or unique identifier
@new_country_name VARCHAR(255) -- New name to update
AS  
BEGIN 

    UPDATE [ipl].[dim_Country]
    SET country_name = @new_country_name
    WHERE country_id = @country_id;
END;  
GO

---------2) [ipl].[dim_City]

CREATE PROCEDURE spUpdateIplCityById
    @city_id INT,                -- Primary key or unique identifier for the city
    @new_city_name VARCHAR(255),  -- New name to update
	@country_id int
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the city name based on the city_id
    UPDATE [ipl].[dim_City]
    SET city_name = @new_city_name,
	Country_Id = @country_id
    WHERE city_id = @city_id;
END;
GO

exec spUpdateIplCityById ?,?,?

----------3) [ipl].[dim_Team]

CREATE PROCEDURE spUpdateIplTeamById
    @team_id INT,                -- Primary key or unique identifier for the team
    @new_team_name VARCHAR(255)  -- New name to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the team name based on the team_id
    UPDATE [ipl].[dim_Team]
    SET team_name = @new_team_name
    WHERE team_id = @team_id;
END;
GO

execute spUpdateIplTeamById ?,?

----------4) [ipl].[dim_Venue]

CREATE PROCEDURE spUpdateIplVenueById
    @venue_id INT,                -- Primary key or unique identifier for the venue
    @new_venue_name VARCHAR(255), -- New name to update
    @city_id INT                  -- New city_id to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the venue name and city_id based on the venue_id
    UPDATE [ipl].[dim_Venue]
    SET venue_name = @new_venue_name,
        city_id = @city_id
    WHERE venue_id = @venue_id;
END;
GO

exec spUpdateIplVenueById ?,?,?


-----------5) [ipl].[dim_Toss_Decision]

CREATE PROCEDURE spUpdateIplTossDecisionById
    @toss_id INT,                -- Primary key or unique identifier for the toss decision
    @new_toss_name VARCHAR(255)  -- New name to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the toss name based on the toss_id
    UPDATE [ipl].[dim_Toss_Decision]
    SET toss_name = @new_toss_name
    WHERE toss_id = @toss_id;
END;
GO

----------6) [ipl].[dim_Role]

CREATE PROCEDURE spUpdateIplRoleById
    @Role_id INT,                 -- Primary key or unique identifier for the role
    @new_Role_Desc VARCHAR(255)   -- New description to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the role description based on the Role_id
    UPDATE [ipl].[dim_Role]
    SET Role_Desc = @new_Role_Desc
    WHERE Role_id = @Role_id;
END;
GO

----------7) [ipl].[dim_Batting_Style]

CREATE PROCEDURE spUpdateIplBattingStyleById
    @batting_id INT,                 -- Primary key or unique identifier for the batting style
    @new_batting_hand VARCHAR(255)   -- New batting hand to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the batting hand based on the batting_id
    UPDATE [ipl].[dim_Batting_Style]
    SET batting_hand = @new_batting_hand
    WHERE batting_id = @batting_id;
END;
GO

----------8) [ipl].[dim_Bowling_Style]

CREATE PROCEDURE spUpdateIplBowlingStyleById
    @bowling_id INT,                 -- Primary key or unique identifier for the bowling style
    @new_bowling_style VARCHAR(255)  -- New bowling style to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the bowling style based on the bowling_id
    UPDATE [ipl].[dim_Bowling_Style]
    SET bowling_style = @new_bowling_style
    WHERE bowling_id = @bowling_id;
END;
GO

----------9) [ipl].[dim_Extra_Type]

CREATE PROCEDURE spUpdateIplExtraTypeById
    @Extra_id INT,                 -- Primary key or unique identifier for the extra type
    @new_Extra_name VARCHAR(255)   -- New extra name to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the extra name based on the Extra_id
    UPDATE [ipl].[dim_Extra_Type]
    SET Extra_name = @new_Extra_name
    WHERE Extra_id = @Extra_id;
END;
GO


exec spUpdateIplExtraTypeById ?,?



---------10) [ipl].[dim_Out_Type]

CREATE PROCEDURE spUpdateIplOutTypeById
    @out_id INT,                 -- Primary key or unique identifier for the out type
    @new_out_name VARCHAR(255)   -- New out name to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the out name based on the out_id
    UPDATE [ipl].[dim_Out_Type]
    SET out_name = @new_out_name
    WHERE out_id = @out_id;
END;
GO


-----------11) [ipl].[dim_Outcome]

CREATE PROCEDURE spUpdateIplOutcomeById
    @outcome_id INT,                  -- Primary key or unique identifier for the outcome
    @new_outcome_type VARCHAR(255)    -- New outcome type to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the outcome type based on the outcome_id
    UPDATE [ipl].[dim_Outcome]
    SET outcome_type = @new_outcome_type
    WHERE outcome_id = @outcome_id;
END;
GO


-----------12) [ipl].[dim_Player]

CREATE PROCEDURE spUpdateIplPlayerById
    @player_id INT,                   -- Primary key or unique identifier for the player
    @new_player_name VARCHAR(255),    -- New player name to update
    @new_dob DATE,                    -- New date of birth to update
    @new_batting_hand VARCHAR(255),   -- New batting hand to update
    @new_bowling_skill VARCHAR(255),  -- New bowling skill to update
    @new_country_name VARCHAR(255)    -- New country name to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the player details based on the player_id
    UPDATE [ipl].[dim_Player]
    SET 
        player_name = @new_player_name,
        dob = @new_dob,
        batting_hand = @new_batting_hand,
        bowling_skill = @new_bowling_skill,
        country_name = @new_country_name
    WHERE player_id = @player_id;
END;
GO

---------13) [ipl].[dim_Win_By]

CREATE PROCEDURE spUpdateIplWinById
    @Win_id INT,                 -- Primary key or unique identifier for the win type
    @new_Win_type VARCHAR(255)   -- New win type to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the win type based on the Win_id
    UPDATE [ipl].[dim_Win_By]
    SET Win_type = @new_Win_type
    WHERE Win_id = @Win_id;
END;
GO

----------14) [ipl].[dim_Season]


CREATE PROCEDURE spUpdateIplSeasonById
    @season_id INT,                       -- Primary key or unique identifier for the season
    @new_Man_of_the_series VARCHAR(255),  -- New Man of the Series to update
    @new_Orange_Cap VARCHAR(255),         -- New Orange Cap holder to update
    @new_purple_cap VARCHAR(255),         -- New Purple Cap holder to update
    @new_Season_year INT                  -- New season year to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the season details based on the season_id
    UPDATE [ipl].[dim_Season]
    SET 
        Man_of_the_series = @new_Man_of_the_series,
        Orange_Cap = @new_Orange_Cap,
        purple_cap = @new_purple_cap,
        Season_year = @new_Season_year
    WHERE season_id = @season_id;
END;
GO


----------15) [ipl].[fact_Match]


CREATE PROCEDURE spUpdateIplMatchById
    @Match_id INT,                     -- Primary key or unique identifier for the match
    @new_team1 VARCHAR(255),           -- New team1 to update
    @new_team2 VARCHAR(255),           -- New team2 to update
    @new_match_date DATE,              -- New match date to update
    @new_season_id INT,                -- New season ID to update
    @new_venue_id INT,                 -- New venue ID to update
    @new_top_winner VARCHAR(255),      -- New top winner to update
    @new_toss_decide VARCHAR(255),     -- New toss decision to update
    @new_win_type VARCHAR(255),        -- New win type to update
    @new_win_margin INT,               -- New win margin to update
    @new_outcome_type VARCHAR(255),    -- New outcome type to update
    @new_match_winner VARCHAR(255),    -- New match winner to update
    @new_man_of_the_match VARCHAR(255) -- New man of the match to update
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the match details based on the Match_id
    UPDATE [ipl].[fact_Match]
    SET 
        Team_1 = @new_team1,
        Team_2 = @new_team2,
        match_date = @new_match_date,
        season_id = @new_season_id,
        venue_id = @new_venue_id,
        Toss_Winner = @new_top_winner,
        toss_decide = @new_toss_decide,
        win_type = @new_win_type,
        win_margin = @new_win_margin,
        outcome_type = @new_outcome_type,
        match_winner = @new_match_winner,
        man_of_the_match = @new_man_of_the_match
    WHERE Match_id = @Match_id;
END;
GO