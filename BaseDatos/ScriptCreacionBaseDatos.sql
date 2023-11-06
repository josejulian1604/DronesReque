USE [master]
GO
/****** Object:  Database [DronesReque]    Script Date: 11/6/2023 3:01:47 PM ******/
CREATE DATABASE [DronesReque]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DronesReque', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DronesReque.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DronesReque_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DronesReque_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DronesReque] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DronesReque].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DronesReque] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DronesReque] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DronesReque] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DronesReque] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DronesReque] SET ARITHABORT OFF 
GO
ALTER DATABASE [DronesReque] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DronesReque] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DronesReque] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DronesReque] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DronesReque] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DronesReque] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DronesReque] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DronesReque] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DronesReque] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DronesReque] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DronesReque] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DronesReque] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DronesReque] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DronesReque] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DronesReque] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DronesReque] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DronesReque] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DronesReque] SET RECOVERY FULL 
GO
ALTER DATABASE [DronesReque] SET  MULTI_USER 
GO
ALTER DATABASE [DronesReque] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DronesReque] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DronesReque] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DronesReque] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DronesReque] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DronesReque] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DronesReque', N'ON'
GO
ALTER DATABASE [DronesReque] SET QUERY_STORE = OFF
GO
USE [DronesReque]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 11/6/2023 3:01:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
	[Apellido] [varchar](128) NOT NULL,
	[Cedula] [varchar](128) NOT NULL,
	[Correo] [varchar](128) NOT NULL,
	[Direccion] [varchar](128) NOT NULL,
	[Telefono] [varchar](128) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dron]    Script Date: 11/6/2023 3:01:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dron](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Modelo] [varchar](128) NOT NULL,
	[Capacidad] [int] NOT NULL,
 CONSTRAINT [PK_Dron] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reporte]    Script Date: 11/6/2023 3:01:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporte](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdServicio] [int] NOT NULL,
 CONSTRAINT [PK_Reporte] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servicio]    Script Date: 11/6/2023 3:01:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NOT NULL,
	[IdTipoServicio] [int] NOT NULL,
	[IdDron] [int] NOT NULL,
	[Descripcion] [varchar](600) NOT NULL,
	[Costo] [money] NOT NULL,
	[Cultivo] [varchar](128) NOT NULL,
	[FechaContrato] [date] NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[Estado] [int] NOT NULL,
	[Area] [varchar](128) NOT NULL,
 CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoServicio]    Script Date: 11/6/2023 3:01:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [varchar](128) NOT NULL,
 CONSTRAINT [PK_TipoServicio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoUsuario]    Script Date: 11/6/2023 3:01:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rol] [varchar](60) NOT NULL,
 CONSTRAINT [PK_TipoUsuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/6/2023 3:01:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
	[Apellido] [varchar](128) NOT NULL,
	[Correo] [varchar](128) NOT NULL,
	[Password] [varchar](128) NOT NULL,
	[IdTipoUsuario] [int] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reporte]  WITH CHECK ADD  CONSTRAINT [FK_Reporte_Servicio] FOREIGN KEY([IdServicio])
REFERENCES [dbo].[Servicio] ([Id])
GO
ALTER TABLE [dbo].[Reporte] CHECK CONSTRAINT [FK_Reporte_Servicio]
GO
ALTER TABLE [dbo].[Servicio]  WITH CHECK ADD  CONSTRAINT [FK_Servicio_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([Id])
GO
ALTER TABLE [dbo].[Servicio] CHECK CONSTRAINT [FK_Servicio_Cliente]
GO
ALTER TABLE [dbo].[Servicio]  WITH CHECK ADD  CONSTRAINT [FK_Servicio_Dron] FOREIGN KEY([IdDron])
REFERENCES [dbo].[Dron] ([Id])
GO
ALTER TABLE [dbo].[Servicio] CHECK CONSTRAINT [FK_Servicio_Dron]
GO
ALTER TABLE [dbo].[Servicio]  WITH CHECK ADD  CONSTRAINT [FK_Servicio_TipoServicio] FOREIGN KEY([IdTipoServicio])
REFERENCES [dbo].[TipoServicio] ([Id])
GO
ALTER TABLE [dbo].[Servicio] CHECK CONSTRAINT [FK_Servicio_TipoServicio]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_TipoUsuario] FOREIGN KEY([IdTipoUsuario])
REFERENCES [dbo].[TipoUsuario] ([Id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_TipoUsuario]
GO
USE [master]
GO
ALTER DATABASE [DronesReque] SET  READ_WRITE 
GO
