% Parámetros del sistema
m = 0.35; % kg (masa)
b = 0.45;   % Ns/m (coeficiente de amortiguación)

% Crear función de transferencia V(s)/F(s) = 1/(m*s + b)
num = 1;
den = [m b 1];
V = tf(num, den);

% Mostrar la función de transferencia
disp('Función de transferencia V(s):');
V

% Tiempo de simulación
t = 0:0.01:5;

% Entrada: escalón unitario (step force)
figure;
step(V, t);
title('Respuesta al escalón del sistema masa-amortiguador');
xlabel('Tiempo (s)');
ylabel('Velocidad v(t) [m/s]');
grid on;

% Entrada: rampa unitaria (fuerza gradual)
rampa = t; % Define la señal de rampa
figure;
lsim(V, rampa, t);  % simula respuesta a rampa
title('Respuesta a la rampa del sistema masa-amortiguador');
xlabel('Tiempo (s)');
ylabel('Velocidad v(t) [m/s]');
grid on;
