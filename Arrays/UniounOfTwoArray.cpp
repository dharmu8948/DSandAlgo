//  WAP to find the union of two array
#include <bits/stdc++.h>
using namespace std;
int main() {
    vector<int> arr1{1,3,4,6,8};
    vector<int> arr2{3,4,5,6,9};
    set<int> ans;
    
   for(int i=0;i<arr1.size();i++) {
       ans.insert(arr1[i]);
   }
   for(int i=0;i<arr2.size();i++) {
       ans.insert(arr2[i]);
   }
    for (auto itr = ans.begin(); itr != ans.end(); itr++)
        cout << *itr << " "; // ans will contain only distinct

    return 0;
}