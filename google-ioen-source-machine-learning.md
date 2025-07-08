# Google Matchine Learning 04AUG22

## Responsible AI Toolkit

- Fairness indicators
  - Highly contextual
  - Hard to define statistically
  - Dashboard for rapid analysis and sharing insights
- what-if tool

## Tensor Flow Hub

- Find others that have solved similar problem as a good starting point
- Find ML models for various needs
  - Documentation
  - Sample Code
  - Try right in browser
  - Image, text, audio, video
  - [tfhub.dev](https://tfhub.dev)
  - One line of code, pull in trained models to use on your dataset
- library
  - Load and KerasLayers

```python
import tensorflow as tf
import tensorflow_hub as hub

model_handel = 'https://tfhub.dev/google/yamnet/1'
model = hub.load(model_handel)
waveform = load_my_wafeform()


```

### Transfer learning

- Image, text, audio, video
- Already have a model that knows how to do something
  - Make this model learn about another specific case
  - Model already knows how to extract features

[link](https://tsnsorflow.org/hub/tutoriald/tf2_image_retraining)

```python

import tensorflow_hub as hub

model = tf.keras.Sequential([
    hub.KerasLayer(
        'https://tfhub.dev/google/cropnet/feature_vector/concat/1'),
        tf.keras.layers.Dense(64, activation = 'relu),
        tf.keras.layers.Dense(num_classes
    )
])

model.compile(...)
model.fit(train_dataset, epochs=10, validation_data=eval_dataset)
```

- Great for Kaggle / hackathons
- Get a quick benchmark

## On-Device Machine Learning

- Edge devices, mobile / IoT, useful for modeling
- Low latency
- Close-knit interactions
- Augmented Reality
- Google Translate
- TensorFlow Lite is a framework for deploying ML on mobile devices and embedded Systems
- EffecientDet-Lite - image classification of over 70 categories
- YAMNet - sound classification
- Download pre-trained tensofflow lite model from tensor flow hub
- efficientdet/lite0
- TensorFlow Lite Task Library
- pip install tflite-support

## Job Que

[kueue.sh](https://kueue.sh)

