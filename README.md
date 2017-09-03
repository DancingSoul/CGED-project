Code for Exploring Segment Representations for Neural Segmentation Models
=========================================================================

This is the code base for simplified Chinese grammar error diagnosis.

# Prerequisite

1. cmake (~2.8)
2. git (~1.8)
3. g++ (~4.6 for c++11 features, 4.8 is used in this paper)
4. boost (~1.57)
5. pyltp and model file (pos.model, cws.model) which can be downloaded at https://pan.baidu.com/share/link?shareid=1988562907&uk=2738088569#list/path=%2Fltp-models%2F3.3.1

# Compile

Execute the following command to compile.

```
git submodule init
git submodule update
source compile.sh
```
You should find the following executable file:

* `./bin/text-bigram`: LSTM-based CGED system.

# Data format

## Input format

## Bigram embedding format

In the same format with word2vec.

example:


# Process the data
  python data_utils.py ...
  python split.py ...
  python crf_to_cnn.py ... 
  python data_utils_for_test.py
  python split.py
  python crf_to_cnn.py

# Running command

./text-bigram 
  --cnn-mem 1024          The allocated memory for nn module. 
  --training_data arg     The path to the training data.
  --devel_data arg        The path to the development data.
  --testing_data arg      The path to the testing data.
  --pretrained arg        The path to the pretrained bigram word embedding.
  --model_name arg        The path to the model of this training phase.
  --model_file arg        The path to the model which was trained before.
  --layers arg (=1)       number of LSTM layers
  --bigram_dim arg (=100) input bigram embedding size
  --unigram_dim arg (=50) unigram dimension
  --pos_dim arg (=16)     POS dimension
  --hidden_dim arg (=128) hidden dimension
  --input_dim arg (=128)  LSTM input dimension
  --maxiter arg (=10)     Max number of iterations.
  --log_file arg          The path to the predicted file.
  -h [ --help ]           Show help information

e.g. ./text-bigram --cnn-mem 1024 --training_data ~/data/HSK_Train.txt --devel_data ~/data/HSK_Test.txt --testing_data ~/data/HSK_Test.txt --pretrained ~/data/embed/bigram_100.embed --maxiter 50 --layers 1 --input_dim 128 --hidden_dim 128 --unigram_dim 50 --bigram_dim 100 --pos_dim 32 --model_name 123.param --log_file 123.output

  python merge_tag.py ...

# Get help
Write to Bo Zheng <dsoul0621@gmail.com>.