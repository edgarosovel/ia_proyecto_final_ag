close all;
clear all;
clc;

fitnessFunction = @fitness;
populationSize = 100;
elitism = 5;
generations = 200;
umbralGeneration = 0.5;
umbralCruzamiento = 0.3;
umbralMutation = 0.9;
left = 0;
right = 150;

[x, y, fval] = ga(fitnessFunction,populationSize,elitism,generations,umbralGeneration,umbralCruzamiento,umbralMutation,left,right)
