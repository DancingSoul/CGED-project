Code for LSTM-Based Chinese Grammatical Error Diagnosis
=========================================================================

This is the code base for simplified Chinese grammatical error diagnosis.

# Prerequisite

1. cmake (~2.8)
2. git (~1.8)
3. g++ (~4.6 for c++11 features, 4.8 is used in this paper)
4. boost (~1.57)
5. pyltp and model file (pos.model, cws.model) which can be downloaded at https://pan.baidu.com/share/link?shareid=1988562907&uk=2738088569#list/path=%2Fltp-models%2F3.3.1.

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

## Bigram embedding format

In the same format with word2vec.

Example:
```
417096 100
中国 0.024400 0.173748 ... ...
<DIGIT>年 0.167508 0.507304 ... ...
们是 -0.424980 0.200127 ... ...
... ...
```
For more training details, please refer to https://pdfs.semanticscholar.org/c1d3/954b4b1951c8584d7feab94115b4816b577f.pdf?_ga=2.218577950.685477658.1504413069-2127118014.1458554462


# Process the data
Put `cws.model` and `pos.model` into dir src first.  
```
  python data_utils.py ../data/CGED16_HSK_TrainingSet_Fixed.txt ../data/train.txt ../data/dev.txt 2000  
  python data_utils_for_test.py ../data/CGED16_HSK_Test_Input_Fixed.txt ../data/test.txt  
  python split.py ../data/train.txt ../data/train_short.txt  
  python split.py ../data/dev.txt ../data/dev_short.txt  
  python split.py ../data/test.txt ../data/test_short.txt  
  python crf_to_cnn.py ../data/train_short.txt ../data/train_short_cnn.txt  
  python crf_to_cnn.py ../data/dev_short.txt ../data/dev_short_cnn.txt  
  python crf_to_cnn.py ../data/test_short.txt ../data/test_short_cnn.txt  
```

# Running command
```
./text-bigram   
  --cnn-mem 1024          The allocated memory for nn module.   
  --training_data arg     The path to the training data.  
  --devel_data arg        The path to the development data.  
  --testing_data arg      The path to the testing data.  
  --pretrained arg        The path to the pretrained bigram word embedding.  
  --model_name arg        The path to the model of this training phase.  
  --model_file arg        The path to the model which was trained before.  
  --layers arg (=1)       number of LSTM layers.  
  --bigram_dim arg (=100) input bigram embedding size.  
  --unigram_dim arg (=50) unigram dimension.  
  --pos_dim arg (=16)     POS dimension.  
  --hidden_dim arg (=128) hidden dimension.  
  --input_dim arg (=128)  LSTM input dimension.  
  --maxiter arg (=10)     Max number of iterations.  
  --log_file arg          The path to the predicted file.  
  -h [ --help ]           Show help information.  
```
e.g. `./text-bigram --cnn-mem 1024 --training_data ../data/train_short_cnn.txt --devel_data ../data/dev_short_cnn.txt --testing_data ~/data/test_short_cnn.txt --maxiter 50 --layers 1 --input_dim 128 --hidden_dim 128 --unigram_dim 50 --bigram_dim 100 --pos_dim 32 --model_name cged.param --log_file cged.output`

  finally, run the following command to recover testing output of original length.
```
  python merge_tag.py cged.output ../data/test.txt cged_orginal.output
```

# Get help
Write to Bo Zheng <dsoul0621@gmail.com>.