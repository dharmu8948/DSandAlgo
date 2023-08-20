// WAP for Bubble sort
#include <bits/stdc++.h>
using namespace std;
int main() {
   vector<int> arr = {10,23,12,55,11,95,19,87,24};
   cout<<"After Sorting:"<<endl;
   for(int round=1;round<arr.size();round++) {
       int swapCount = 0;
       for(int j=0;j<arr.size()-round;j++) {
           if(arr[j]>arr[j+1]) {
               swap(arr[j], arr[j+1]);
               swapCount++;
           }
       }
       if(swapCount == 0) {
           // sort ho chuka hai no need to check further elements
           break;
       }
   }
   for(int i=0;i<arr.size();i++) {
       cout<<arr[i]<<" ";
   }
    return 0;
}