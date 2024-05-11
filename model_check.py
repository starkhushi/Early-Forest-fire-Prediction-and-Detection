import numpy as np
import tensorflow as tf

# Load TFLite model
interpreter = tf.lite.Interpreter(model_path="model.tflite")
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Define input data
Temperature = 235.0
RH = 60.0
Ws = 10.0
Rain = 0.0
FFMC = 90.0
DMC = 30.0
ISI = 35.0

# Prepare input data
input_data = np.array([[Temperature, RH, Ws, Rain, FFMC, DMC, ISI]], dtype=np.float32)

# Run inference
interpreter.set_tensor(input_details[0]['index'], input_data)
interpreter.invoke()
output_data = interpreter.get_tensor(output_details[0]['index'])

# Display result
print("FWI Score:", output_data[0])
