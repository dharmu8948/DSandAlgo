// GFG Link : https://www.geeksforgeeks.org/problems/sort-in-specific-order2422/1
/*
Input: arr[] = [1, 2, 3, 5, 4, 7, 10]
Output: [7, 5, 3, 1, 2, 4, 10]
Explanation: 7, 5, 3, 1 are odd numbers in descending order and 2, 4, 10 are even numbers in ascending order.
----------------------------------------------
Input: arr[] = [0, 4, 5, 3, 7, 2, 1]
Output: [7, 5, 3, 1, 0, 2, 4]
Explanation: 7, 5, 3, 1 are odd numbers in descending order and 0, 2, 4 are even numbers in ascending order.
*/
#include <bits/stdc++.h>
using namespace std;

void sortInSpecific(vector<int>&arr) {
    for(int i = 0; i< arr.size();i++) {
            if(arr[i] % 2 != 0) arr[i] = -arr[i]; 
        }
        sort(arr.begin(), arr.end());
        for(int i = 0;i<arr.size();i++) {
            if(arr[i] < 0 && arr[i]%2 != 0) arr[i] = -arr[i]; 
        }
}
int main() {
	vector<int> arr = {1, 2, 3, 5, 4, 7, 10};
	sortInSpecific(arr);
	for(int num : arr) {
	    cout<<num<<" ";
	}
	cout<<endl;

}
