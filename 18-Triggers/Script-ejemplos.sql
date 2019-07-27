--****************************************************
-- Bases de datos: Triggers
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: Junio 2019
--****************************************************


CREATE PROCEDURE BOOK  
	@id INT,
	@checkin_str VARCHAR(30),
	@checkout_str VARCHAR(30),
	@id_cliente INT,
	@id_habitacion INT
AS
BEGIN
	DECLARE @checkin DATETIME;
	DECLARE @checkout  DATETIME;
	SET @checkin = CAST(@checkin_str AS DATETIME);
	SET @checkout = CAST(@checkout_str AS DATETIME);
	BEGIN TRANSACTION;

	BEGIN TRY 
		INSERT INTO reserva VALUES(@id,@checkin,@checkout,@id_cliente,@id_habitacion);		
		COMMIT TRANSACTION 
	END TRY
	BEGIN CATCH
		PRINT('Error al intentar insertar datos...');
		ROLLBACK;
	END CATCH
END;

DROP PROCEDURE BOOK;

EXEC BOOK 110,'11-1-2010 15:00:00' ,'13-1-2010 13:00:00',6,3;


CREATE TRIGGER check_res 
	ON reserva
	AFTER INSERT
	AS BEGIN
		--declarando variables
		DECLARE @fecha DATETIME;
		DECLARE @id_habitacion INT;
		--obteniendo datos desde tabla inserted
		SELECT @id_habitacion=i.id_habitacion, @fecha=i.checkin from inserted i;

		IF EXISTS (SELECT * FROM reserva WHERE checkin=@fecha AND id_habitacion=@id_habitacion )
		BEGIN
			Print 'Consulta invàlida, la habitaciòn ya ha sido reservada....';
			ROLLBACK TRANSACTION
		END
	END;




DROP TRIGGER check_res;
SELECT * FROM reserva ORDER BY id DESC;
DELETE FROM reserva WHERE id=101;


SELECT * FROM reserva WHERE checkin=@fecha AND id_habitacion=@id_habitacion 

INSERT INTO reserva VALUES(101,CAST('11-1-2010 15:00:00.000' AS DATETIME),CAST('13-1-2010 13:00:00.000' AS DATETIME),6,3);





CREATE TRIGGER trCuenta
	ON CUENTA
	AFTER UPDATE --evento que se escuchará en el trigger
	AS
	BEGIN
		SET NOCOUNT ON --evita que se generen mensajes de texto

		DECLARE @numeroCuenta VARCHAR(26);
		DECLARE @saldoActual FLOAT, @saldoAnterior FLOAT;
		DECLARE @transaccion VARCHAR(15);

		--¿que tipo de transacción será?
		SELECT @saldoAnterior = saldo FROM deleted;
		SELECT @numeroCuenta=numeroCuenta, @saldoActual=saldo FROM inserted;

		IF @saldoActual > @saldoAnterior 
			SET @transaccion = 'Abono';
		IF @saldoActual < @saldoAnterior 
			SET @transaccion = 'Retiro';
		IF @saldoActual = @saldoAnterior 
			SET @transaccion = 'noModificacion';	
			
		--guardando en la tabla registro
		INSERT INTO REGISTRO( numeroCuenta, SaldoAnterior, SaldoActual, tipoTransaccion, fecha)
			VALUES(@numeroCuenta, @saldoAnterior, @saldoActual, @transaccion, CONVERT(VARCHAR, getdate(), 100));
	END;