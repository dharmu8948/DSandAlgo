// WAP for selection sort
#include <bits/stdc++.h>
using namespace std;
int main() {
   vector<int> arr = {100,23,12,55,11,95,19,87,24};
   cout<<"After Sorting:"<<endl;
   for(int i=0;i<arr.size()-1;i++) {
       int minIndex = i;
       for(int j=i+1;j<arr.size();j++) {
           if(arr[j]<arr[minIndex]) {
               minIndex = j;
           }
       }
       swap(arr[i],arr[minIndex]);
   }
   for(int i=0;i<arr.size();i++) {
       cout<<arr[i]<<" ";
   }
    return 0;
}