# %%
import numpy as np
import os

from tflite_model_maker.config import QuantizationConfig
from tflite_model_maker.config import ExportFormat
from tflite_model_maker import model_spec
from tflite_model_maker import object_detector

import tensorflow as tf
assert tf.__version__.startswith('2')

tf.get_logger().setLevel('ERROR')
from absl import logging
logging.set_verbosity(logging.ERROR)
#run_opts = tf.RunOptions(report_tensor_allocations_upon_oom = True)

# %%
TRAINING = 'annotations_train.csv'
VALIDATION = 'annotations_validation.csv'
TEST = 'annotations_test.csv'

# %%
spec = model_spec.get('efficientdet_lite4')

# %%
train_data, _validation_data, _test_data = object_detector.DataLoader.from_csv(TRAINING)
_train_data, validation_data, _test_data = object_detector.DataLoader.from_csv(VALIDATION)
_train_data, _validation_data, test_data = object_detector.DataLoader.from_csv(TEST)

# %%
print('Training data size:', train_data.size)
print('Validation data size:', validation_data.size)
print('Test data size:', test_data.size)

# %%
model = object_detector.create(train_data, model_spec=spec, batch_size=8, train_whole_model=True, validation_data=validation_data)

# %%


# %%
model.export(export_dir='.', export_format=[ExportFormat.SAVED_MODEL, ExportFormat.LABEL])

# %%
model.export(export_dir='.', tflite_filename='model.tflite', quantization_config=QuantizationConfig.for_float16(), export_format=[ExportFormat.TFLITE])

# %%
model.evaluate(test_data)

# %%
#test model.tflite with test_set
from_file = model.create('model.tflite', 'labels.txt')
from_file.evaluate(test_data)

# %%



