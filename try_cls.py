import streamlit as st
import tensorflow as tf
import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression

# Load the saved TensorFlow Lite model
interpreter = tf.lite.Interpreter(model_path="model_cls.tflite")
interpreter.allocate_tensors()

# Get input and output tensors.
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Function to preprocess input data for TensorFlow Lite model
def preprocess_input(X):
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    return X_scaled.astype(np.float32)

# Function to make predictions using TensorFlow Lite model
def predict_tflite(X):
    input_data = preprocess_input(X)
    interpreter.set_tensor(input_details[0]['index'], input_data)
    interpreter.invoke()
    output_data = interpreter.get_tensor(output_details[0]['index'])
    return output_data

# Load the Logistic Regression model
logistic_model = LogisticRegression()
logistic_model.fit(X_train_scaled, z_train)

# Function to make predictions using Logistic Regression model
def predict_logistic(X):
    return logistic_model.predict(X)

# Streamlit UI
st.title("Forest Fire Prediction")

# Add inputs
st.sidebar.header('User Input Parameters')

def user_input_features():
    FFMC = st.sidebar.slider('Fine Fuel Moisture Code (FFMC)', 18.7, 96.2, 90.0)
    DMC = st.sidebar.slider('Duff Moisture Code (DMC)', 1.1, 291.3, 70.0)
    ISI = st.sidebar.slider('Initial Spread Index (ISI)', 0.0, 56.1, 9.0)
    temp = st.sidebar.slider('Temperature (C)', 2.2, 33.3, 25.0)
    RH = st.sidebar.slider('Relative Humidity (%)', 15.0, 100.0, 70.0)
    wind = st.sidebar.slider('Wind Speed (km/h)', 0.40, 9.40, 4.0)
    rain = st.sidebar.slider('Rain (mm/m^2)', 0.0, 6.4, 0.0)
    data = {'FFMC': FFMC,
            'DMC': DMC,
            'ISI': ISI,
            'temp': temp,
            'RH': RH,
            'wind': wind,
            'rain': rain}
    features = pd.DataFrame(data, index=[0])
    return features

input_df = user_input_features()

# Make predictions
logistic_prediction = predict_logistic(input_df)
tflite_prediction = predict_tflite(input_df.values)

st.header('Logistic Regression Prediction')
st.write("Probability of forest fire: ", logistic_prediction)

st.header('TensorFlow Lite Model Prediction')
st.write("Probability of forest fire: ", tflite_prediction)
