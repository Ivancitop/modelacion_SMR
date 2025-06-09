% Parámetros del sistema
r = 1000; % ohms
c = 50/1000000;   % capacitancia

% Crear función de transferencia V(s)/F(s) = 1/(m*s + b)
num = 1;
den = [(r*c) 1];
V = tf(num, den);

% Mostrar la función de transferencia
disp('Función de transferencia V(s):');
V

% Tiempo de simulación
t = 0:0.01:12;

% Entrada: escalón unitario (step force)
figure;
step(V, t);
title('Respuesta al escalón del sistema RC');
xlabel('Tiempo (s)');
ylabel('Voltaje v(t)');
grid on;

% Entrada: rampa unitaria (fuerza gradual)
rampa = t; % Define la señal de rampa
figure;
lsim(V, rampa, t);  % simula respuesta a rampa
title('Respuesta a la rampa del RC');
xlabel('Tiempo (s)');
ylabel('Voltaje v(t)');
grid on;
