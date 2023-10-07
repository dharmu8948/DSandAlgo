#include <iostream>
using namespace std;

int main() 
{
    int n;
    cin>>n;
    
    for(int i=1;i<=n;i++) {
      int k = 1;
      for(int j = 1;j<2*n;j++) {
        if(j>=(n-i+1) && j<=(n-1+i) && k) {
          cout<<"*";
          k = 0;
        }else {
          cout<<" ";
          k = 1;
        }
      }
      cout<<endl;
    }
}