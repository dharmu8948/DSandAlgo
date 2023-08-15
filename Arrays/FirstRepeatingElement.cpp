 // Function to return the position of the first repeating element.
    int firstRepeated(int arr[], int n) {
        //  for(int i=0;i<n-1;i++) {
        //      for(int j=i+1;j<n;j++) {
        //          if(arr[i] == arr[j])
        //          return i+1;
        //      }
        //  }
        //  return -1;
        // seacond approach
        // created map to store element vs count of it
        unordered_map<int, int> hash;
        for(int i=0;i<n;i++) {
            hash[arr[i]]++;
        }
        for(int i=0;i<n;i++) {
            // checking if count is greater than 1 then return the index
            if(hash[arr[i]]>1) {
                return i+1;
            }
        }
        return -1;
    }