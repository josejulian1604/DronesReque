SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE CrearServicio
	
	@inDescripcion		VARCHAR(600),
	@inCosto			MONEY,
	@inCultivo			VARCHAR(128),
	@inFechaContrato	DATE,
	@inFechaInicio		DATE,
	@inFechaFin			DATE,
	@inEstado			INT,
	@inArea				VARCHAR(128),
	@inCliente			VARCHAR(128),
	@inDron				VARCHAR(128),
	@inTipoServicio		VARCHAR(128)
AS
BEGIN
	
	SET NOCOUNT ON;

    INSERT INTO [dbo].[Servicio] (
		[IdCliente],
		[IdTipoServicio],
		[IdDron],
		[Descripcion],
		[Costo],
		[Cultivo],
		[FechaContrato],
		[FechaInicio],
		[FechaFin],
		[Estado],
		[Area]
	)
	SELECT
		C.Id,
		TS.Id,
		D.Id,
		@inDescripcion,
		@inCosto,
		@inCultivo,
		@inFechaContrato,
		@inFechaInicio,
		@inFechaFin,
		@inEstado,
		@inArea
	FROM [dbo].[Cliente] C
	INNER JOIN [dbo].[TipoServicio] TS ON TS.Tipo = @inTipoServicio
	INNER JOIN [dbo].[Dron] D ON D.Modelo = @inDron
	WHERE (C.Nombre = @inCliente);
END
GO