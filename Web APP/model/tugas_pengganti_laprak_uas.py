# -*- coding: utf-8 -*-
"""Tugas Pengganti Laprak UAS

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1H9ugQrLjxBz5jvBCc5N5OZRtuYZqC37c
"""

#import libraries we need
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.linear_model import LinearRegression

#web app application
import pickle

df = pd.read_csv('D:\\Kuliah\\Praktikum Komputasi Statistika 2\\2117_infinite_loop\\model\\df_outfield.csv')

#Here we're going to make a Multiple Linear Regression to predict Release Clause
reg_data = df.loc[:,
                  ['Age', 'Value', 'Wage', 'Height',
                   'Weight','Release Clause']].copy()
reg_data = reg_data[reg_data['Release Clause']!= 0].reset_index(drop = True)

# We're going to make 3 models, using LinearRegression, RidgeRegression and LassoRegression
''' Linear Regression '''
x = reg_data.loc[:,reg_data.columns !='Release Clause']
y = reg_data.loc[:,reg_data.columns == 'Release Clause']

regression = LinearRegression()
lr = regression.fit(x,y)

pickle.dump(lr, open("D:\\Kuliah\\Praktikum Komputasi Statistika 2\\2117_infinite_loop\\model\\model.pkl",'wb'))

print(lr.predict([[33, 67000000, 420000, 170.18, 72.12]]))  # format of input
print(f'score: {lr.score(x, y)}')
