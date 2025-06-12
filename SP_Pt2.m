Simulación de sistema 1/4 suspensión
Definición de sistema y parámetros:
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

C_full = eye(4);  % observamos todos los estados
D_full = zeros(4,1);
sys_full = ss(A, B, C_full, D_full);

% Tiempo
t = 0:0.01:5;  % 5 segundos

Entrada de escalón
u1 = ones(size(t));  % escalón unitario
% Simulación completa para escalón
[y_step, ~] = lsim(sys_full, u1, t);  % y_step contiene x1, x2, x3, x4

% Aceleración del carro: derivada de la velocidad (x2)
a_step = [0; diff(y_step(:,2))./diff(t')];  % estimación numérica

figure;
subplot(3,1,1);
plot(t, y_step(:,1), 'LineWidth', 2);
ylabel('Desplazamiento (m)');
title('Respuesta a entrada tipo Escalón');
grid on;

subplot(3,1,2);
plot(t, y_step(:,2), 'LineWidth', 2);
ylabel('Velocidad (m/s)');
grid on;

subplot(3,1,3);
plot(t, a_step, 'LineWidth', 2);
ylabel('Aceleración (m/s²)');
xlabel('Tiempo (s)');
grid on;


Entrada de rampa
u2 = t;
[y_ramp, ~] = lsim(sys_full, u2, t);
a_ramp = [0; diff(y_ramp(:,2))./diff(t')];

figure;
subplot(3,1,1);
plot(t, y_ramp(:,1), 'LineWidth', 2);
title('Respuesta a entrada tipo Rampa');
ylabel('Desplazamiento (m)');
grid on;

subplot(3,1,2);
plot(t, y_ramp(:,2), 'LineWidth', 2);
ylabel('Velocidad (m/s)');
grid on;

subplot(3,1,3);
plot(t, a_ramp, 'LineWidth', 2);
ylabel('Aceleración (m/s²)');
xlabel('Tiempo (s)');
grid on;


Entrada de perfil senoidal (camino ondulado)
% Entrada senoidal (1 Hz)
f = 1;
u3 = sin(2*pi*f*t);
[y_seno, ~] = lsim(sys_full, u3, t);
a_seno = [0; diff(y_seno(:,2))./diff(t')];

figure;
subplot(3,1,1);
plot(t, y_seno(:,1), 'LineWidth', 2);
title('Respuesta a entrada tipo Senoidal');
ylabel('Desplazamiento (m)');
grid on;

subplot(3,1,2);
plot(t, y_seno(:,2), 'LineWidth', 2);
ylabel('Velocidad (m/s)');
grid on;

subplot(3,1,3);
plot(t, a_seno, 'LineWidth', 2);
ylabel('Aceleración (m/s²)');
xlabel('Tiempo (s)');
grid on;


Entrada de Road Bump (bache localizado)
% Entrada tipo bache
u4 = zeros(size(t));
bump_duration = (t >= 1 & t <= 2);
u4(bump_duration) = sin(pi*(t(bump_duration) - 1));  % medio senoide

[y_bump, ~] = lsim(sys_full, u4, t);
a_bump = [0; diff(y_bump(:,2))./diff(t')];

figure;
subplot(3,1,1);
plot(t, y_bump(:,1), 'LineWidth', 2);
title('Respuesta a entrada tipo Bache (Road bump)');
ylabel('Desplazamiento (m)');
grid on;

subplot(3,1,2);
plot(t, y_bump(:,2), 'LineWidth', 2);
ylabel('Velocidad (m/s)');
grid on;

subplot(3,1,3);
plot(t, a_bump, 'LineWidth', 2);
ylabel('Aceleración (m/s²)');
xlabel('Tiempo (s)');
grid on;

