USE [master]
GO
/****** Object:  Database [NotesMarketplace]    Script Date: 27-03-2021 18:01:16 ******/
CREATE DATABASE [NotesMarketplace]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NotesMarketplace', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NotesMarketplace.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NotesMarketplace_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NotesMarketplace_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NotesMarketplace] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NotesMarketplace].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ARITHABORT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NotesMarketplace] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NotesMarketplace] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NotesMarketplace] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NotesMarketplace] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NotesMarketplace] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NotesMarketplace] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NotesMarketplace] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NotesMarketplace] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NotesMarketplace] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NotesMarketplace] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NotesMarketplace] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NotesMarketplace] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NotesMarketplace] SET RECOVERY FULL 
GO
ALTER DATABASE [NotesMarketplace] SET  MULTI_USER 
GO
ALTER DATABASE [NotesMarketplace] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NotesMarketplace] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NotesMarketplace] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NotesMarketplace] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NotesMarketplace] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NotesMarketplace', N'ON'
GO
ALTER DATABASE [NotesMarketplace] SET QUERY_STORE = OFF
GO
USE [NotesMarketplace]
GO
/****** Object:  Table [dbo].[AdminProfile]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminProfile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[F.K/User] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[ProfilePicture] [varchar](max) NULL,
	[SecondaryEmail] [varchar](30) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_AdminProfile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTC]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTC](
	[P.K/CTC] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_CTC] PRIMARY KEY CLUSTERED 
(
	[P.K/CTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DownloadedNotes]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DownloadedNotes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[F.K/Note] [int] NOT NULL,
	[F.K/User/Seller] [int] NOT NULL,
	[F.K/User/Buyer] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[SellPrice] [int] NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Category] [varchar](100) NOT NULL,
	[Attachment] [varchar](max) NULL,
 CONSTRAINT [PK_DownloadedNotes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAQ]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAQ](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NOT NULL,
	[question] [varchar](max) NOT NULL,
	[answer] [varchar](max) NOT NULL,
 CONSTRAINT [PK_FAQ] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[F.K/Note] [int] NOT NULL,
	[F.K/User] [int] NOT NULL,
	[Review] [int] NOT NULL,
	[Comments] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManageCTC]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManageCTC](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[F.K/CTC] [int] NOT NULL,
	[Value] [varchar](100) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[CountryCode] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ManageCTC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotesDetails]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesDetails](
	[P.K/Note] [int] IDENTITY(1,1) NOT NULL,
	[F.K/User] [int] NOT NULL,
	[F.K/NoteStatus] [int] NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Category] [varchar](100) NOT NULL,
	[BookPicture] [varchar](max) NULL,
	[NoteAttachment] [varchar](max) NOT NULL,
	[NoteType] [varchar](100) NULL,
	[NumberOfPages] [int] NULL,
	[NotesDescription] [varchar](max) NOT NULL,
	[InstitutionName] [varchar](200) NULL,
	[Country] [varchar](100) NULL,
	[Course] [varchar](100) NULL,
	[CourseCode] [varchar](100) NULL,
	[Professor] [varchar](100) NULL,
	[SellPrice] [int] NOT NULL,
	[NotePreview] [varchar](max) NULL,
	[NoteSize] [int] NULL,
	[PublishedDate] [datetime] NULL,
	[Remark] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_NotesDetails] PRIMARY KEY CLUSTERED 
(
	[P.K/Note] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotesStatus]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotesStatus](
	[P.K/NotesStatus] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_NotesStatus] PRIMARY KEY CLUSTERED 
(
	[P.K/NotesStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpamReport]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpamReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[F.K/Note] [int] NOT NULL,
	[F.K/User] [int] NOT NULL,
	[Remark] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SpamReport] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statistics]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statistics](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[F.K/User] [int] NOT NULL,
	[UnderReviewNotes] [int] NOT NULL,
	[PublishedNotes] [int] NOT NULL,
	[DownloadedNotes] [int] NOT NULL,
	[TotalExpensis] [int] NOT NULL,
	[TotalEarning] [int] NOT NULL,
	[BuyerRequests] [int] NOT NULL,
	[SoldNotes] [int] NOT NULL,
	[RejectedNotes] [int] NOT NULL,
 CONSTRAINT [PK_Statistics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemConfiguration]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfiguration](
	[ID] [int] NOT NULL,
	[EmaillId1] [varchar](100) NOT NULL,
	[EmailId2] [varchar](100) NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
	[DefaultProfilePicture] [varchar](max) NOT NULL,
	[DefaultNotePreview] [varchar](max) NOT NULL,
	[FacebookUrl] [varchar](50) NOT NULL,
	[TwitterUrl] [varchar](50) NOT NULL,
	[LinkInUrl] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_SystemConfiguration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[ID] [int] NOT NULL,
	[F.K/User] [int] NOT NULL,
	[DOB] [datetime] NULL,
	[Gender] [varchar](10) NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[ProfilePicture] [varchar](max) NULL,
	[Address1] [varchar](100) NOT NULL,
	[Address2] [varchar](100) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZipCode] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[University] [varchar](100) NULL,
	[College] [varchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_UserProfile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[P.K/UserRoles] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[P.K/UserRoles] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 27-03-2021 18:01:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[P.K/User] [int] IDENTITY(0,1) NOT NULL,
	[F.K/UserRoles] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[EmailId] [varchar](100) NOT NULL,
	[Password] [varchar](24) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[IsDetailsSubmitted] [bit] NOT NULL,
	[CreaatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[P.K/User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CTC] ON 

INSERT [dbo].[CTC] ([P.K/CTC], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Category', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CTC] ([P.K/CTC], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Type', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[CTC] ([P.K/CTC], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'Counties', NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CTC] OFF
GO
SET IDENTITY_INSERT [dbo].[DownloadedNotes] ON 

INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3009, 3, 21, 23, 1, CAST(N'2021-03-18T14:40:54.490' AS DateTime), NULL, NULL, NULL, 1, 120, N'dcdd', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3010, 8, 21, 23, 1, CAST(N'2021-03-18T14:41:10.437' AS DateTime), NULL, NULL, NULL, 1, 120, N'sirst Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3011, 11, 21, 23, 1, CAST(N'2021-03-18T14:41:35.477' AS DateTime), NULL, NULL, NULL, 1, 120, N'First Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3012, 15, 21, 23, 1, CAST(N'2021-03-18T14:41:45.853' AS DateTime), NULL, NULL, NULL, 1, 120, N'dvdv', N'IT', N'2127022021110855.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3013, 19, 21, 23, 1, CAST(N'2021-03-18T14:41:53.583' AS DateTime), NULL, NULL, NULL, 1, 0, N'dNote_update2.0', N'IT', N'2128022021142031.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3014, 29, 21, 23, 1, CAST(N'2021-03-18T14:42:00.057' AS DateTime), NULL, NULL, NULL, 1, 120, N'adfsdfdafda', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3015, 34, 21, 23, 1, CAST(N'2021-03-18T14:42:10.430' AS DateTime), NULL, NULL, NULL, 1, 120, N'sirst Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3016, 37, 21, 23, 1, CAST(N'2021-03-18T14:42:18.417' AS DateTime), NULL, NULL, NULL, 1, 120, N'First Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3017, 8, 21, 25, 1, CAST(N'2021-03-18T14:43:15.547' AS DateTime), NULL, NULL, NULL, 1, 120, N'sirst Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3018, 11, 21, 25, 1, CAST(N'2021-03-18T14:43:21.927' AS DateTime), NULL, NULL, NULL, 1, 120, N'First Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3019, 15, 21, 25, 1, CAST(N'2021-03-18T14:43:29.930' AS DateTime), NULL, NULL, NULL, 1, 120, N'dvdv', N'IT', N'2127022021110855.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3020, 29, 21, 25, 1, CAST(N'2021-03-18T14:43:36.867' AS DateTime), NULL, NULL, NULL, 1, 120, N'adfsdfdafda', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3021, 34, 21, 25, 1, CAST(N'2021-03-18T14:43:44.683' AS DateTime), NULL, NULL, NULL, 1, 120, N'sirst Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3022, 60, 21, 25, 1, CAST(N'2021-03-18T14:43:55.237' AS DateTime), NULL, NULL, NULL, 1, 120, N'sirst Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3023, 55, 21, 25, 1, CAST(N'2021-03-18T14:44:05.653' AS DateTime), NULL, NULL, NULL, 1, 120, N'dfsdsdfs', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3024, 3, 21, 25, 0, CAST(N'2021-03-18T14:49:26.567' AS DateTime), NULL, NULL, NULL, 1, 120, N'dcdd', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3025, 19, 21, 25, 1, CAST(N'2021-03-18T14:49:48.430' AS DateTime), NULL, NULL, NULL, 1, 0, N'dNote_update2.0', N'IT', N'2128022021142031.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3026, 37, 21, 25, 0, CAST(N'2021-03-18T14:50:01.090' AS DateTime), NULL, NULL, NULL, 1, 120, N'First Note', N'IT', N'2127022021103745.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (3027, 151, 21, 25, 1, CAST(N'2021-03-18T14:50:18.903' AS DateTime), NULL, NULL, NULL, 1, 0, N'Final patel demo', N'IT', N'2106032021092341.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (4009, 41, 21, 25, 0, CAST(N'2021-03-21T15:50:37.840' AS DateTime), NULL, NULL, NULL, 1, 120, N'dvdv', N'IT', N'2127022021110855.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (4010, 151, 21, 23, 1, CAST(N'2021-03-21T15:57:12.740' AS DateTime), NULL, NULL, NULL, 1, 0, N'Final patel demo', N'IT', N'2106032021092341.pdf')
INSERT [dbo].[DownloadedNotes] ([ID], [F.K/Note], [F.K/User/Seller], [F.K/User/Buyer], [IsApproved], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifedBy], [IsActive], [SellPrice], [Title], [Category], [Attachment]) VALUES (4011, 41, 21, 23, 0, CAST(N'2021-03-21T16:44:20.160' AS DateTime), NULL, NULL, NULL, 1, 120, N'dvdv', N'IT', N'2127022021110855.pdf')
SET IDENTITY_INSERT [dbo].[DownloadedNotes] OFF
GO
SET IDENTITY_INSERT [dbo].[FAQ] ON 

INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (1, N'General Questions', N'What is Marketplace-Notes?', N'Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod.')
INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (2, N'General Questions', N'Where did Notes Marketplace start?', N'What started out as four friends chucking around an idea in Ahmedabad ended up turning into an
earliest version of Notes Marketplace. So, with 2021 batch of tatvasoft – we has developed this product.')
INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (3, N'Uploaders', N'Why should I upload now?', N'To maximize sales. We can''t sell your notes if they are rotting on your hard drive. Your notes are
available for purchase the instant they are approved, which means that you could be missing potential
sales as we speak. Despite exam and holiday breaks, our users purchase notes all year round, so the best
time to upload notes is always today.')
INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (4, N'Uploaders', N'What can''t I sell?', N'We won''t approve materials that have been created by your university or another third party. We also
do not accept assignments, essays, practical’s or take-home exams. We love notes though.')
INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (5, N'Uploaders', N'How long does it take to upload?', N'Uploading notes is quick and easy. It can take as little as 90 seconds per set of notes. Put it this way, in
the time it took to read these FAQs, you could’ve uploaded several sets of notes.')
INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (6, N'Downloaders', N'How do I buy notes?', N'Search for the notes you are after using the ''SEARCH NOTES'' tab at the at the top right of every page.
You can then filter results by university, category, course information etc. To purchase, go to detail page
of note and click on download button. If notes are free to download – it will download over the browser
and if notes are paid, Once Seller will allow download you can have notes at my downloads grid for
actual download.')
INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (7, N'Downloaders', N'Why should I buy notes?', N'The notes on our site are incredibly useful as an educational tool when used correctly. They effectively
demonstrate the techniques that top students employ in order to receive top marks. They also
summaries the course in a concise format and show what that student believed were the most
important elements of the course. Learn from the best.')
INSERT [dbo].[FAQ] ([ID], [type], [question], [answer]) VALUES (8, N'Downloaders', N'Will downloading notes guarantee I improve my grades?', N'How long is a piece of string? However, 90% of students who purchased notes through our site said that
doing so improved their grades.')
SET IDENTITY_INSERT [dbo].[FAQ] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([ID], [F.K/Note], [F.K/User], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 151, 23, 4, N'Testing!!', CAST(N'2021-03-23T10:07:59.940' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Feedback] ([ID], [F.K/Note], [F.K/User], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 37, 23, 4, N'Testing!!', CAST(N'2021-03-23T10:08:16.217' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Feedback] ([ID], [F.K/Note], [F.K/User], [Review], [Comments], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 151, 25, 3, N'wow!', CAST(N'2021-03-23T10:09:07.897' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[ManageCTC] ON 

INSERT [dbo].[ManageCTC] ([ID], [F.K/CTC], [Value], [Description], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 3, N'India', N'aaa', 91, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([ID], [F.K/CTC], [Value], [Description], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 3, N'U.K', N'aaa', 43, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([ID], [F.K/CTC], [Value], [Description], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 1, N'IT', N'aaa', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([ID], [F.K/CTC], [Value], [Description], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 1, N'Computer', N'aaa', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([ID], [F.K/CTC], [Value], [Description], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 2, N'val1', N'aaa', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ManageCTC] ([ID], [F.K/CTC], [Value], [Description], [CountryCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 2, N'val2', N'aaa', NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[ManageCTC] OFF
GO
SET IDENTITY_INSERT [dbo].[NotesDetails] ON 

INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, 21, 4, N'dcdd', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.583' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, 21, 2, N'First Note', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.350' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, 21, 1, N'znote', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-03-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (7, 21, 2, N'anotw', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (8, 21, 4, N'sirst Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (9, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-17T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (10, 21, 3, N'dNotev2', N'IT', NULL, N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, CAST(N'2021-03-09T15:47:18.977' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (11, 21, 4, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2020-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (12, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (13, 21, 2, N'First Note', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (14, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-01-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (15, 21, 4, N'dvdv', N'IT', N'2127022021110855.PNG', N'2127022021110855.pdf', N'val1', 33, N'hhuh', N'kj', N'India', N'jj', N'77', N'jb', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T11:08:55.870' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (16, 21, 1, N'Edit_Demo', N'IT', N'2128022021135239.PNG', N'2128022021135239.pdf', N'val1', 33, N'Edit-Demo', N'Cspit', N'India', N'aa', N'88', N'ff', 150, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-28T13:52:39.963' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (17, 21, 3, N'Edit_Demo_done', N'IT', N'2128022021141320.PNG', N'2128022021141320.pdf', N'val2', 33, N'Edit-Demo', N'Cspit', N'India', N'aa', N'88', N'ff', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:13:20.373' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (18, 21, 1, N'dNote_update', N'IT', NULL, N'2128022021141920.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:19:20.640' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (19, 21, 4, N'dNote_update2.0', N'IT', NULL, N'2128022021142031.pdf', N'val1', 44, N'second note', N'ss', N'U.K', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:20:31.887' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (20, 21, 1, N'dNote_update2.0', N'IT', NULL, N'2128022021142142.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:21:42.753' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (21, 21, 1, N'dNote_update3.0', N'IT', NULL, N'2128022021142519.pdf', NULL, 44, N'second note', N'ss', NULL, N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:25:19.393' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (22, 21, 1, N'adda', N'IT', NULL, N'2128022021142812.pdf', NULL, 44, N'second note', N'ss', NULL, N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:28:12.463' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (23, 21, 3, N'dNote_update5.0', N'IT', NULL, N'2101032021165754.pdf', NULL, NULL, N'dd', NULL, NULL, NULL, NULL, NULL, 0, NULL, 152447, NULL, NULL, CAST(N'2021-03-01T15:59:13.320' AS DateTime), NULL, CAST(N'2021-03-01T16:57:54.930' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (24, 21, 3, N'new_old', N'IT', NULL, N'2101032021164129.pdf', NULL, NULL, N'njn', NULL, NULL, NULL, NULL, NULL, 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-01T16:02:38.653' AS DateTime), NULL, CAST(N'2021-03-01T16:41:37.063' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (25, 21, 1, N'new_old', N'IT', NULL, N'2101032021162511.pdf', NULL, NULL, N'njn', NULL, NULL, NULL, NULL, NULL, 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-01T16:25:11.320' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (26, 21, 4, N'new_old', N'IT', NULL, N'2101032021162733.pdf', NULL, NULL, N'njn', NULL, NULL, NULL, NULL, NULL, 0, NULL, 152447, NULL, NULL, CAST(N'2021-03-01T16:27:33.337' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (27, 21, 1, N'abcd', N'IT', N'2101032021170448.PNG', N'2101032021170448.pdf', N'val1', 66, N'jji', N'jnj', N'India', N'mk', N'98', N'hb', 1600, NULL, 50844, NULL, NULL, CAST(N'2021-03-01T17:04:48.890' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (28, 21, 3, N'dosub', N'IT', NULL, N'2101032021170653.pdf', NULL, NULL, N'ok', NULL, NULL, NULL, NULL, NULL, 0, N'2127022021103745.pdf', 152447, NULL, NULL, CAST(N'2021-03-01T17:06:53.647' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (29, 21, 4, N'adfsdfdafda', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (30, 21, 2, N'First Note', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (31, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (32, 21, 1, N'znote', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-03-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (33, 21, 2, N'anotw', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (34, 21, 4, N'sirst Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (35, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-17T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (36, 21, 3, N'abcde', N'IT', NULL, N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, CAST(N'2021-03-17T11:42:58.243' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (37, 21, 4, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2020-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (38, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (39, 21, 2, N'First Note', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (40, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-01-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (41, 21, 4, N'dvdv', N'IT', N'2127022021110855.PNG', N'2127022021110855.pdf', N'val1', 33, N'hhuh', N'kj', N'India', N'jj', N'77', N'jb', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T11:08:55.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (42, 21, 1, N'Edit_Demo', N'IT', N'2128022021135239.PNG', N'2128022021135239.pdf', N'val1', 33, N'Edit-Demo', N'Cspit', N'India', N'aa', N'88', N'ff', 150, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-28T13:52:39.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (43, 21, 3, N'Edit_Demo_done', N'IT', N'2128022021141320.PNG', N'2128022021141320.pdf', N'val2', 33, N'Edit-Demo', N'Cspit', N'India', N'aa', N'88', N'ff', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:13:20.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (44, 21, 1, N'dNote_update', N'IT', NULL, N'2128022021141920.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:19:20.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (45, 21, 4, N'dNote_update2.0', N'IT', NULL, N'2128022021142031.pdf', N'val1', 44, N'second note', N'ss', N'U.K', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:20:31.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (46, 21, 1, N'dNote_update2.0', N'IT', NULL, N'2128022021142142.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:21:42.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (47, 21, 1, N'dNote_update3.0', N'IT', NULL, N'2128022021142519.pdf', NULL, 44, N'second note', N'ss', NULL, N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:25:19.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (48, 21, 1, N'dNote_update3.0', N'IT', NULL, N'2128022021142812.pdf', NULL, 44, N'second note', N'ss', NULL, N'first', N'88', N'njn', 0, NULL, 50844, NULL, NULL, CAST(N'2021-02-28T14:28:12.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (49, 21, 3, N'dNote_update5.0', N'IT', NULL, N'2101032021165754.pdf', NULL, NULL, N'dd', NULL, NULL, NULL, NULL, NULL, 0, NULL, 152447, NULL, NULL, CAST(N'2021-03-01T15:59:13.000' AS DateTime), NULL, CAST(N'2021-03-01T16:57:54.000' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (50, 21, 3, N'new_old', N'IT', NULL, N'2101032021164129.pdf', NULL, NULL, N'njn', NULL, NULL, NULL, NULL, NULL, 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-01T16:02:38.000' AS DateTime), NULL, CAST(N'2021-03-01T16:41:37.000' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (51, 21, 1, N'new_old', N'IT', NULL, N'2101032021162511.pdf', NULL, NULL, N'njn', NULL, NULL, NULL, NULL, NULL, 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-01T16:25:11.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (52, 21, 4, N'new_old', N'IT', NULL, N'2101032021162733.pdf', NULL, NULL, N'njn', NULL, NULL, NULL, NULL, NULL, 0, NULL, 152447, NULL, NULL, CAST(N'2021-03-01T16:27:33.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (53, 21, 3, N'abcd_v2', N'IT', NULL, N'2109032021153208.pdf', N'val1', 66, N'jji', N'jnj', N'India', N'mk', N'98', N'hb', 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-01T17:04:48.000' AS DateTime), NULL, CAST(N'2021-03-09T15:32:08.150' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (54, 21, 3, N'dosub', N'IT', NULL, N'2101032021170653.pdf', NULL, NULL, N'ok', NULL, NULL, NULL, NULL, NULL, 0, NULL, 152447, NULL, NULL, CAST(N'2021-03-01T17:06:53.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (55, 21, 4, N'dfsdsdfs', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (56, 21, 2, N'First Note', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (57, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (58, 21, 1, N'znote', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-03-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 0)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (59, 21, 2, N'anotw', N'IT', N'2127022021103841.PNG', N'2127022021103841.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (60, 21, 4, N'sirst Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-27T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (61, 21, 3, N'First Note', N'IT', N'2127022021103745.PNG', N'2127022021103745.pdf', N'val1', 45, N'first note ', N'Cspit', N'India', N'first', N'56', N'hu', 120, N'2127022021103745.pdf', 50844, NULL, NULL, CAST(N'2021-02-17T10:37:45.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (62, 21, 3, N'dNote', N'IT', N'2117032021113703.jpg', N'2109032021153537.pdf', N'val1', 44, N'second note', N'ss', N'India', N'first', N'88', N'njn', 0, NULL, 106000, NULL, NULL, CAST(N'2021-02-27T10:38:41.000' AS DateTime), NULL, CAST(N'2021-03-17T11:37:03.700' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (151, 21, 4, N'Final patel demo', N'IT', N'2106032021092341.PNG', N'2106032021092341.pdf', N'val1', 34, N'Tesing book dn sjhjs ajnkd ', NULL, NULL, NULL, NULL, NULL, 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-06T09:23:41.033' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (152, 23, 4, N'abcd_mybool', N'IT', NULL, N'2306032021093051.pdf', NULL, NULL, N'demo', NULL, NULL, NULL, NULL, NULL, 100, NULL, 152447, NULL, NULL, CAST(N'2021-03-06T09:30:51.673' AS DateTime), NULL, CAST(N'2021-03-17T11:15:04.170' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (153, 21, 3, N'Savmy not', N'Computer', NULL, N'2109032021153002.pdf', N'val1', 77, N'nj', N'j', N'India', N'lmk', N'8', N'hv', 0, NULL, 106000, NULL, NULL, CAST(N'2021-03-09T15:22:19.207' AS DateTime), NULL, CAST(N'2021-03-09T15:30:02.937' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (154, 21, 3, N'publish note', N'IT', NULL, N'2109032021152734.pdf', NULL, NULL, N'jn', NULL, NULL, NULL, NULL, NULL, 0, NULL, 152447, NULL, NULL, CAST(N'2021-03-09T15:27:34.277' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1153, 21, 3, N'Testing_Rejected Notes_v2', N'Computer', NULL, N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, NULL, 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.740' AS DateTime), NULL, CAST(N'2021-03-23T18:21:10.580' AS DateTime), NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1154, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1155, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1156, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1157, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1158, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1159, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1160, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1161, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1162, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1163, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1164, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1165, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1166, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1167, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1168, 21, 5, N'Testing_Rejected Notes', N'Computer', N'2123032021172656.png', N'2123032021172656.pdf', N'val1', 55, N'testing...', N'Cspit', N'India', N'abcd', N'aa', N'tt', 0, N'2123032021172656.pdf', 50844, NULL, N'Rejcted by Admin', CAST(N'2021-03-23T17:26:56.000' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1169, 21, 3, N'aa', N'IT', NULL, N'2123032021181855.pdf', NULL, NULL, N'aa', NULL, NULL, NULL, NULL, NULL, 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-23T18:18:55.613' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[NotesDetails] ([P.K/Note], [F.K/User], [F.K/NoteStatus], [Title], [Category], [BookPicture], [NoteAttachment], [NoteType], [NumberOfPages], [NotesDescription], [InstitutionName], [Country], [Course], [CourseCode], [Professor], [SellPrice], [NotePreview], [NoteSize], [PublishedDate], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1170, 21, 3, N'abc', N'IT', NULL, N'2123032021181934.pdf', NULL, NULL, N'aa', NULL, NULL, NULL, NULL, NULL, 0, NULL, 50844, NULL, NULL, CAST(N'2021-03-23T18:19:34.180' AS DateTime), NULL, CAST(N'2021-03-23T18:19:59.230' AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[NotesDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[NotesStatus] ON 

INSERT [dbo].[NotesStatus] ([P.K/NotesStatus], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Draft', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesStatus] ([P.K/NotesStatus], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'In Review', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesStatus] ([P.K/NotesStatus], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'Submitted', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesStatus] ([P.K/NotesStatus], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (4, N'Published', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesStatus] ([P.K/NotesStatus], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (5, N'Rejected', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[NotesStatus] ([P.K/NotesStatus], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (6, N'Unpublished', NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[NotesStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[SpamReport] ON 

INSERT [dbo].[SpamReport] ([ID], [F.K/Note], [F.K/User], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, 151, 23, N'done!!', CAST(N'2021-03-23T09:36:01.317' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[SpamReport] ([ID], [F.K/Note], [F.K/User], [Remark], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, 151, 25, N'Bad!!', CAST(N'2021-03-23T10:09:22.860' AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SpamReport] OFF
GO
SET IDENTITY_INSERT [dbo].[Statistics] ON 

INSERT [dbo].[Statistics] ([ID], [F.K/User], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpensis], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (1, 21, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistics] ([ID], [F.K/User], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpensis], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (2, 23, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistics] ([ID], [F.K/User], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpensis], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (3, 25, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Statistics] ([ID], [F.K/User], [UnderReviewNotes], [PublishedNotes], [DownloadedNotes], [TotalExpensis], [TotalEarning], [BuyerRequests], [SoldNotes], [RejectedNotes]) VALUES (4, 26, 0, 0, 0, 0, 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Statistics] OFF
GO
INSERT [dbo].[UserProfile] ([ID], [F.K/User], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [State], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (21, 21, NULL, N'Male', N'+917359665133', N'21hfhbshvbadyig.png', N'Narsang Tekri', N'Siddhivinayak Park', N'Caucasian/White', N'Gujarat', N'380006', N'India', N'Cspit', N'Cspit', CAST(N'2021-03-17T11:35:54.010' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfile] ([ID], [F.K/User], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [State], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (23, 23, NULL, N'Female', N'+437359665133', N'23hfhbshvbadyig.png', N'Narsang Tekri', N'Siddhivinayak Park', N'Ahmedabad', N'GUJARAT', N'380006', N'U.K', N'efef', N'err', CAST(N'2021-03-17T10:28:14.003' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfile] ([ID], [F.K/User], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [State], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (25, 25, CAST(N'2021-03-19T00:00:00.000' AS DateTime), N'Female', N'+917359665133', N'25hfhbshvbadyig.png', N'Narsang Tekri', N'Siddhivinayak Park', N'Porbandar', N'Gujarat', N'380006', N'U.K', NULL, NULL, CAST(N'2021-03-19T13:37:11.560' AS DateTime), NULL, 1)
INSERT [dbo].[UserProfile] ([ID], [F.K/User], [DOB], [Gender], [PhoneNumber], [ProfilePicture], [Address1], [Address2], [City], [State], [ZipCode], [Country], [University], [College], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (26, 26, NULL, NULL, N'+917359665133', NULL, N'Narsang Tekri', N'Siddhivinayak Park', N'Ahmedabad', N'Gujarat', N'380006', N'India', NULL, NULL, CAST(N'2021-03-04T12:51:29.717' AS DateTime), NULL, 1)
GO
INSERT [dbo].[UserRoles] ([P.K/UserRoles], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (1, N'Member', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserRoles] ([P.K/UserRoles], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (2, N'Admin', NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserRoles] ([P.K/UserRoles], [Name], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (3, N'SuperAdmin', NULL, NULL, NULL, NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([P.K/User], [F.K/UserRoles], [FirstName], [LastName], [EmailId], [Password], [IsEmailVerified], [IsDetailsSubmitted], [CreaatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (21, 1, N'tatsav', N'chovatiya', N'tatsav.chovatiya@GMAIl.COM', N'123456', 1, 1, CAST(N'2021-02-20T14:00:19.327' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([P.K/User], [F.K/UserRoles], [FirstName], [LastName], [EmailId], [Password], [IsEmailVerified], [IsDetailsSubmitted], [CreaatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (23, 1, N'tatsav', N'patel', N'Tatsav000@gmail.com', N'123456', 1, 1, CAST(N'2021-03-03T14:43:29.443' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([P.K/User], [F.K/UserRoles], [FirstName], [LastName], [EmailId], [Password], [IsEmailVerified], [IsDetailsSubmitted], [CreaatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (25, 1, N'test', N'first', N'test123@GMAIl.COM', N'123456', 1, 1, CAST(N'2021-03-04T12:27:43.787' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Users] ([P.K/User], [F.K/UserRoles], [FirstName], [LastName], [EmailId], [Password], [IsEmailVerified], [IsDetailsSubmitted], [CreaatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) VALUES (26, 1, N'test', N'second', N'test456@gmail.com', N'123456', 1, 1, CAST(N'2021-03-04T12:50:37.883' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_Users]    Script Date: 27-03-2021 18:01:31 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED 
(
	[P.K/User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdminProfile] ADD  CONSTRAINT [DF_AdminProfile_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CTC] ADD  CONSTRAINT [DF_CTC_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[DownloadedNotes] ADD  CONSTRAINT [DF_DownloadedNotes_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[DownloadedNotes] ADD  CONSTRAINT [DF_DownloadedNotes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT ((0)) FOR [Review]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ManageCTC] ADD  CONSTRAINT [DF_ManageCTC_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[NotesDetails] ADD  CONSTRAINT [DF_NotesDetails_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[NotesStatus] ADD  CONSTRAINT [DF_NotesStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [UnderReviewNotes]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [PublishedNotes]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [DownloadedNotes]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [TotalExpensis]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [TotalEarning]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [BuyerRequests]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [SoldNotes]
GO
ALTER TABLE [dbo].[Statistics] ADD  DEFAULT ((0)) FOR [RejectedNotes]
GO
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserRoles] ADD  CONSTRAINT [DF_UserRoles_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsEmailVerified]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsDetailsSubmitted]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AdminProfile]  WITH CHECK ADD  CONSTRAINT [FK_Admin_Users] FOREIGN KEY([F.K/User])
REFERENCES [dbo].[Users] ([P.K/User])
GO
ALTER TABLE [dbo].[AdminProfile] CHECK CONSTRAINT [FK_Admin_Users]
GO
ALTER TABLE [dbo].[DownloadedNotes]  WITH CHECK ADD  CONSTRAINT [FK_DownloadedNotes_Users] FOREIGN KEY([F.K/User/Seller])
REFERENCES [dbo].[Users] ([P.K/User])
GO
ALTER TABLE [dbo].[DownloadedNotes] CHECK CONSTRAINT [FK_DownloadedNotes_Users]
GO
ALTER TABLE [dbo].[DownloadedNotes]  WITH CHECK ADD  CONSTRAINT [FK_DownloadedNotes_Users1] FOREIGN KEY([F.K/User/Buyer])
REFERENCES [dbo].[Users] ([P.K/User])
GO
ALTER TABLE [dbo].[DownloadedNotes] CHECK CONSTRAINT [FK_DownloadedNotes_Users1]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_NotesDetails] FOREIGN KEY([F.K/Note])
REFERENCES [dbo].[NotesDetails] ([P.K/Note])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_NotesDetails]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Users] FOREIGN KEY([F.K/User])
REFERENCES [dbo].[Users] ([P.K/User])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Users]
GO
ALTER TABLE [dbo].[ManageCTC]  WITH CHECK ADD  CONSTRAINT [FK_ManageCTC_CTC] FOREIGN KEY([F.K/CTC])
REFERENCES [dbo].[CTC] ([P.K/CTC])
GO
ALTER TABLE [dbo].[ManageCTC] CHECK CONSTRAINT [FK_ManageCTC_CTC]
GO
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_NotesStatus] FOREIGN KEY([F.K/NoteStatus])
REFERENCES [dbo].[NotesStatus] ([P.K/NotesStatus])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_NotesStatus]
GO
ALTER TABLE [dbo].[NotesDetails]  WITH CHECK ADD  CONSTRAINT [FK_NotesDetails_Users] FOREIGN KEY([F.K/User])
REFERENCES [dbo].[Users] ([P.K/User])
GO
ALTER TABLE [dbo].[NotesDetails] CHECK CONSTRAINT [FK_NotesDetails_Users]
GO
ALTER TABLE [dbo].[SpamReport]  WITH CHECK ADD  CONSTRAINT [FK_SpamReport_NotesDetails] FOREIGN KEY([F.K/Note])
REFERENCES [dbo].[NotesDetails] ([P.K/Note])
GO
ALTER TABLE [dbo].[SpamReport] CHECK CONSTRAINT [FK_SpamReport_NotesDetails]
GO
ALTER TABLE [dbo].[SpamReport]  WITH CHECK ADD  CONSTRAINT [FK_SpamReport_Users] FOREIGN KEY([F.K/User])
REFERENCES [dbo].[Users] ([P.K/User])
GO
ALTER TABLE [dbo].[SpamReport] CHECK CONSTRAINT [FK_SpamReport_Users]
GO
ALTER TABLE [dbo].[Statistics]  WITH CHECK ADD  CONSTRAINT [FK_Statistics_Users] FOREIGN KEY([F.K/User])
REFERENCES [dbo].[Users] ([P.K/User])
GO
ALTER TABLE [dbo].[Statistics] CHECK CONSTRAINT [FK_Statistics_Users]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [F.K/User_UserProfile] FOREIGN KEY([F.K/User])
REFERENCES [dbo].[Users] ([P.K
/User])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [F.K/User_UserProfile]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles] FOREIGN KEY([F.K/UserRoles])
REFERENCES [dbo].[UserRoles] ([P.K/UserRoles])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_UserRoles]
GO
USE [master]
GO
ALTER DATABASE [NotesMarketplace] SET  READ_WRITE 
GO

