%Simulación de sistema 1/4 suspensión
%Definición de sistema y parámetros:
% Parámetros
m1 = 560;     % masa del carro (kg)
m2 = 45;      % masa de la llanta (kg)
b1 = 4500;    % amortiguamiento entre carro y llanta (Ns/m)
b2 = 300;     % amortiguamiento entre llanta y carretera (Ns/m)
k1 = 30000;   % rigidez entre carro y llanta (N/m)
k2 = 180000;  % rigidez entre llanta y carretera (N/m)

% Matrices del modelo
A = [ 0      1          0        0;
     -k1/m1 -b1/m1      k1/m1    b1/m1;
      0      0          0        1;
      k1/m2  b1/m2 -(k1+k2)/m2 -(b1+b2)/m2 ];

B = [0;
     0;
     0;
     k2/m2 + b2/m2];

C = [1 0 0 0];  % salida: desplazamiento carrocería
D = 0;

% Definir sistema
sys = ss(A, B, C, D);

% Tiempo
t = 0:0.01:5;  % 5 segundos

Entrada de escalón
u1 = ones(size(t));  % escalón unitario
[y1, ~] = lsim(sys, u1, t);

figure;
plot(t, y1, 'LineWidth', 2);
title('Respuesta a entrada tipo Escalón');
xlabel('Tiempo (s)');
ylabel('Desplazamiento x_1 (m)');
grid on;

Entrada de rampa
u2 = t;  % entrada rampa
[y2, ~] = lsim(sys, u2, t);

figure;
plot(t, y2, 'LineWidth', 2);
title('Respuesta a entrada tipo Rampa');
xlabel('Tiempo (s)');
ylabel('Desplazamiento x_1 (m)');
grid on;

Entrada de perfil senoidal (camino ondulado)
f = 1;  % frecuencia 1 Hz
u3 = sin(2*pi*f*t);  % entrada senoidal
[y3, ~] = lsim(sys, u3, t);

figure;
plot(t, y3, 'LineWidth', 2);
title('Respuesta a entrada tipo Senoide (camino ondulado)');
xlabel('Tiempo (s)');
ylabel('Desplazamiento x_1 (m)');
grid on;

Entrada de Road Bump (bache localizado)
u4 = zeros(size(t));
bump_duration = (t >= 1 & t <= 2);
u4(bump_duration) = sin(pi*(t(bump_duration) - 1));  % medio senoide

[y4, ~] = lsim(sys, u4, t);

figure;
plot(t, y4, 'LineWidth', 2);
title('Respuesta a entrada tipo Bache (Road bump)');
xlabel('Tiempo (s)');
ylabel('Desplazamiento x_1 (m)');
grid on;

