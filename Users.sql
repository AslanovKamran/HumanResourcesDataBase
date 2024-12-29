GO
CREATE TABLE Users (
[Id] INT PRIMARY KEY IDENTITY,

[UserName] NVARCHAR (100) UNIQUE NOT NULL,

[Password] NVARCHAR (255) NOT NULL,
[Salt] NVARCHAR (255) NOT NULL, -- Will be used for hashing the password

[FullName] NVARCHAR (100) NULL,
[RoleId] INT FOREIGN KEY  REFERENCES Roles(Id),
[StructureId] INT FOREIGN KEY REFERENCES OrganizationStructures (Id),

[InsertedBy] NVARCHAR (100) NULL,
[InsertedAt] DATE,

[UpdatedBy] NVARCHAR (100) NULL,
[UpdatedAt] DATE NULL,


[PasswordUpdatedBy] NVARCHAR (100) NULL,
[PasswordUpdatedAt] DATE NULL,

[CanEdit] BIT NOT NULL DEFAULT 0
)

CREATE TABLE UsersRights (
    UserId INT NOT NULL FOREIGN KEY REFERENCES Users(Id) ON DELETE CASCADE,
    RightId INT NOT NULL FOREIGN KEY REFERENCES Rights(Id) ON DELETE CASCADE,
    PRIMARY KEY (UserId, RightId)
);

SELECT * FROM Users

CREATE PROCEDURE GetAllUsersInfo
AS
BEGIN
    SELECT 
        usr.Id, 
        usr.UserName, 
        usr.Password, 
        usr.Salt, 
        usr.FullName, 
		rls.Id AS [RoleId], 
        rls.Name AS [Role], 
        org.FullName AS [Structure], 
        usr.InsertedBy, 
        usr.InsertedAt, 
        usr.UpdatedBy, 
        usr.UpdatedAt, 
        usr.PasswordUpdatedBy, 
        usr.PasswordUpdatedAt, 
        usr.CanEdit,
        -- JSON list of Rights with Id included
        (
            SELECT 
                r.Id,
                r.[Key], 
                r.[Name]
            FROM UsersRights AS ur
            JOIN Rights AS r ON r.Id = ur.RightId
            WHERE ur.UserId = usr.Id
            FOR JSON PATH
        ) AS Rights
    FROM Users AS usr
    LEFT JOIN Roles AS rls ON rls.Id = usr.RoleId
    LEFT JOIN OrganizationStructures AS org ON org.Id = usr.StructureId;
END;




CREATE PROCEDURE GetUser @Id INT
AS
BEGIN
    SELECT 
        usr.Id, 
        usr.UserName, 
        usr.Password, 
        usr.Salt, 
        usr.FullName,
		rls.Id AS [RoleId], 
        rls.Name AS [Role], 
        org.FullName AS [Structure], 
        usr.InsertedBy, 
        usr.InsertedAt, 
        usr.UpdatedBy, 
        usr.UpdatedAt, 
        usr.PasswordUpdatedBy, 
        usr.PasswordUpdatedAt, 
        usr.CanEdit,
        -- JSON list of Rights with Id included
        (
            SELECT 
                r.Id,
                r.[Key], 
                r.[Name]
            FROM UsersRights AS ur
            JOIN Rights AS r ON r.Id = ur.RightId
            WHERE ur.UserId = usr.Id
            FOR JSON PATH
        ) AS Rights
    FROM Users AS usr
    LEFT JOIN Roles AS rls ON rls.Id = usr.RoleId
    LEFT JOIN OrganizationStructures AS org ON org.Id = usr.StructureId
	WHERE usr.Id = @Id;
END;





GO
CREATE PROCEDURE InsertUser
    @UserName NVARCHAR(100),
    @Password NVARCHAR(255),
    @Salt NVARCHAR(255),
    @FullName NVARCHAR(100),
    @RoleId INT,
    @StructureId INT = NULL, -- Allow NULL
    @InsertedBy NVARCHAR(100) = NULL, -- Allow NULL
    @CanEdit BIT,
    @Rights NVARCHAR(MAX) = NULL, -- Allow NULL
    @NewUserId INT OUTPUT
AS
BEGIN
    -- Insert the user
    INSERT INTO Users (
        UserName, Password, Salt, FullName, RoleId, StructureId, InsertedBy, InsertedAt, CanEdit
    )
    VALUES (
        @UserName, @Password, @Salt, @FullName, @RoleId, @StructureId, @InsertedBy, GETDATE(), @CanEdit
    );

    -- Get the new UserId
    SET @NewUserId = SCOPE_IDENTITY();

    -- Handle Rights if provided
    IF (@Rights IS NOT NULL AND LEN(@Rights) > 0)
    BEGIN
        DECLARE @RightId NVARCHAR(10);
        DECLARE @RightsCursor CURSOR;

        SET @RightsCursor = CURSOR FOR
            SELECT value
            FROM STRING_SPLIT(@Rights, ',');

        OPEN @RightsCursor;

        FETCH NEXT FROM @RightsCursor INTO @RightId;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO UsersRights (UserId, RightId)
            VALUES (@NewUserId, CAST(@RightId AS INT));

            FETCH NEXT FROM @RightsCursor INTO @RightId;
        END;

        CLOSE @RightsCursor;
        DEALLOCATE @RightsCursor;
    END;
END;

SELECT * FROM Users


GO
CREATE PROCEDURE GetUserByUserName @UserName NVARCHAR (100)
AS
BEGIN
    SELECT 
        usr.Id, 
        usr.UserName, 
        usr.Password, 
        usr.Salt, 
        usr.FullName,
		rls.Id AS [RoleId], 
        rls.Name AS [Role], 
        org.FullName AS [Structure], 
        usr.InsertedBy, 
        usr.InsertedAt, 
        usr.UpdatedBy, 
        usr.UpdatedAt, 
        usr.PasswordUpdatedBy, 
        usr.PasswordUpdatedAt, 
        usr.CanEdit,
        -- JSON list of Rights with Id included
        (
            SELECT 
                r.Id,
                r.[Key], 
                r.[Name]
            FROM UsersRights AS ur
            JOIN Rights AS r ON r.Id = ur.RightId
            WHERE ur.UserId = usr.Id
            FOR JSON PATH
        ) AS Rights
    FROM Users AS usr
    LEFT JOIN Roles AS rls ON rls.Id = usr.RoleId
    LEFT JOIN OrganizationStructures AS org ON org.Id = usr.StructureId
WHERE usr.UserName = @UserName COLLATE Latin1_General_CS_AS
END;

SELECT * FROM UsersRights

SELECT * FROM Users

GO
CREATE PROC ChangePassword 
    @Id INT, 
    @NewPassword NVARCHAR(255)
AS 
BEGIN
    SET NOCOUNT ON;

    -- Check if the user exists
    IF EXISTS (
        SELECT 1 
        FROM [Users] 
        WHERE [Id] = @Id
    )
    BEGIN
       
       

        -- Update the password 
        UPDATE [Users] 
        SET [Password] = @NewPassword,

            [UpdatedAt] = SYSDATETIME() 
        WHERE [Id] = @Id;
    END
    ELSE
    BEGIN
        --If user does not exist, raise an error Raise an error message
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END
END

