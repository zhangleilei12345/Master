'''
Fun:从许多错误解答中获取正确解
Created by: Stephen Z. Cheng
2017-11-18

'''

import numpy as np

def Cal_BTS(x_A, x_B, y_A, y_B, mean_x_A, mean_x_B, log_y_A, log_y_B):
	num_subjects = np.shape(x_A)[0] 
	u = []
	for r in range(num_subjects):
		u.append(x_A[r]*(np.log(mean_x_A)-log_y_A)+x_B[r]*(np.log(mean_x_B)-log_y_B)\
			+mean_x_A*(np.log(y_A[r]/mean_x_A))+mean_x_B*(np.log(y_B[r]/mean_x_B)))
	return np.array(u)

def Cal_Mean_BTS(x_A, x_B,mean_x_A, mean_x_B,u):
	num_subjects = np.shape(x_A)[0] 
	return (np.sum(x_A@u)/(num_subjects*mean_x_A), np.sum(x_B@u)/(num_subjects*mean_x_B))

def FindTruth(x_A, y_A):
	x_B = 1-x_A
	y_B = 1-y_A

	# step1:
	mean_x_A = np.mean(x_A)
	mean_x_B = np.mean(x_B)

	log_y_A = np.mean(np.log(y_A))
	log_y_B = np.mean(np.log(y_B))

	# step2:Calculate the BTS score of each individual r
	u = Cal_BTS(x_A, x_B, y_A, y_B, mean_x_A, mean_x_B, log_y_A, log_y_B)

	# step3:Calculate the average BTS score for each answers
	mean_u = Cal_Mean_BTS(x_A, x_B,mean_x_A, mean_x_B,u)

	# step4: Select the answer
	if np.array(mean_u).argmax()==0:
		print("chosen A")
	else:
		print("chosen B")

# 每一列代表一个被试
X = np.array([1, 0, 1])  # 选择结果，1表示选择A，0表示选择B
Y = np.array([0.91, 0.9, 0.91]) # 预测解的流行程度

print("the result based on the democracy.")
if np.sum(X)/np.shape(X)[0]>0.5:
	print("chosen A")
else:
	print("chosen B")

print("the result calculated on the popular prediction.")

FindTruth(X, Y)



