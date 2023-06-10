/****** Object:  Table [dbo].[Bill] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill]
(
    [BillId]        [uniqueidentifier] NOT NULL,
    [Sum]           [int]              NOT NULL,
    [LeaseNumber]   [uniqueidentifier] NOT NULL,
    [DateOfAccrual] [datetime2](7)     NOT NULL,
    [DateSent ]     [uniqueidentifier] NOT NULL,
    CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED
        (
         [BillId] ASC,
         [DateOfAccrual] ASC
            ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO

/****** Object:  Table [dbo].[PlaceType] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaceType]
(
    [Name]        [nvarchar](50) NOT NULL,
    [SumPerMeter] [int]          NOT NULL
        CONSTRAINT [PK_PlaceType] PRIMARY KEY CLUSTERED
            (
             [Name] ASC
                ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO

/****** Object:  Table [dbo].[Place] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Place]
(
    [Number] [uniqueidentifier] NOT NULL,
    [Type]   [nvarchar](50)     NOT NULL,
    [Area]   [int]              NOT NULL
        CONSTRAINT [PK_Place] PRIMARY KEY CLUSTERED
            (
             [Number] ASC
                ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO

/****** Object:  Table [dbo].[Payment] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment]
(
    [DateOfEnrollment] [datetime2](7) NOT NULL,
    [AmountOwed]       [int]          NOT NULL,
    [TenantName]       [nvarchar](50) NOT NULL
        CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED (
                                                       [DateOfEnrollment] ASC
            ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO

/****** Object:  Table [dbo].[Tenant] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tenant]
(
    [Name]           [nvarchar](50)  NOT NULL,
    [Address]        [nvarchar](max) NOT NULL,
    [BankAccount]    [nvarchar](max) NOT NULL,
    [Director]       [nvarchar](50)  NOT NULL,
    [Characteristic] [text]          Not Null
        CONSTRAINT [PK_Tenant] PRIMARY KEY CLUSTERED (
                                                      [Name] ASC
            ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO

/****** Object:  Table [dbo].[Lease] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lease]
(
    [LeaseNumber]  [uniqueidentifier] NOT NULL,
    [PlaceNumber]  [uniqueidentifier] NOT NULL,
    [TenantName]   [nvarchar](50)     NOT NULL,
    [StartOfLease] [datetime2](7)     NOT NULL,
    [EndOfLease]   [datetime2](7)     NOT NULL
        CONSTRAINT [PK_Lease] PRIMARY KEY CLUSTERED (
                                                     [LeaseNumber] ASC
            ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
/**/
GO
ALTER TABLE [dbo].[Payment]
    WITH CHECK ADD CONSTRAINT [FK_Payment_Lease_TenantName] FOREIGN KEY ([TenantName])
        REFERENCES [dbo].[Tenant] ([Name])
        ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Payment]
    CHECK CONSTRAINT [FK_Payment_Lease_TenantName]

GO
ALTER TABLE [dbo].[Place]
    WITH CHECK ADD CONSTRAINT [FK_Place_PlaceType_Type] FOREIGN KEY ([Type])
        REFERENCES [dbo].[PlaceType] ([Name])
        ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Place]
    CHECK CONSTRAINT [FK_Place_PlaceType_Type]

GO
ALTER TABLE [dbo].[Bill]
    WITH CHECK ADD CONSTRAINT [FK_Bill_Lease_LeaseNumber] FOREIGN KEY ([LeaseNumber])
        REFERENCES [dbo].[Lease] ([LeaseNumber])
        ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bill]
    CHECK CONSTRAINT [FK_Bill_Lease_LeaseNumber]

GO
ALTER TABLE [dbo].[Lease]
    WITH CHECK ADD CONSTRAINT [FK_Lease_Place_PlaceNumber] FOREIGN KEY ([PlaceNumber])
        REFERENCES [dbo].[Place] ([Number])
        ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Lease]
    CHECK CONSTRAINT [FK_Lease_Place_PlaceNumber]

GO
ALTER TABLE [dbo].[Lease]
    WITH CHECK ADD CONSTRAINT [FK_Lease_Tenant_TenantName] FOREIGN KEY ([TenantName])
        REFERENCES [dbo].[Tenant] ([Name])
        ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Lease]
    CHECK CONSTRAINT [FK_Lease_Tenant_TenantName]

/*  INSERT DATA   */
GO
INSERT [dbo].[PlaceType] ([Name], [SumPerMeter]) values (N'Hall', 10)
GO
INSERT [dbo].[PlaceType] ([Name], [SumPerMeter]) values (N'Kovorking', 20)
GO
insert [dbo].[Place] ([Number], [Type], [Area]) values (N'c5a0e131-46a0-4f37-9a9d-6e426cb94f46', N'Hall', 50)
GO

/*  REQUESTS    */
SELECT * FROM dbo.Place
go

SELECT * FROM dbo.PlaceType
go

select * FROM dbo.Place
inner join PlaceType PT on PT.Name = Place.Type