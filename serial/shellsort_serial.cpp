#include <iostream>
#include <random>
#include <cstdlib>
#include <iomanip>
#include <chrono>
#include <algorithm>
#include <vector>


// ----------------------------------------------------------------------------------------------------------------
// Generating the same random numbers( pseudo-random )
// ----------------------------------------------------------------------------------------------------------------
long int gen_numbers( long int range, long int seed )
{ 
      std::mt19937 gen( seed );

      std::uniform_int_distribution<long int> distr(0, range);

      return distr( gen );
}


// ----------------------------------------------------------------------------------------------------------------
// Generating array with random numbers
// ----------------------------------------------------------------------------------------------------------------
long int * gen_array( long int size )
{
    long int * temp_arr = new long int[size];

    for ( int i = 0; i < size; i++ )
    {
        temp_arr[i] = gen_numbers(size, i);
    }
    
    return temp_arr;
}


// ----------------------------------------------------------------------------------------------------------------
// Swaping values
// ----------------------------------------------------------------------------------------------------------------
void swap( long int * a, long int * b)
{

    long int temp = *a;
    *a = *b;
    *b = temp;

}


// ----------------------------------------------------------------------------------------------------------------
// Shell sort
// ----------------------------------------------------------------------------------------------------------------
void shell( long int * arr, long int size )
{

    //GAP -> the distance between the values that will be swapped like an insertion sort.

    for( long int gap = size/2; gap > 0; gap /= 2 )
    {
        // Insertion sort
        for( long int i = gap; i < size; i++ )
        {

            long int aux = arr[i];

            long int itr;

            for( itr = i; itr >= gap && arr[ itr - gap ] > aux; itr -= gap )
            {
                arr[itr] = arr[ itr - gap ];
            }

            // Correct position of the arr[i].
           arr[itr] = aux;
        }
    }

}


// ----------------------------------------------------------------------------------------------------------------
// Printing array
// ----------------------------------------------------------------------------------------------------------------
void print( long int * arr, long int size )
{
    for( long int i = 0; i < size; i++ )
    {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;

}


// ----------------------------------------------------------------------------------------------------------------
// Main
// ----------------------------------------------------------------------------------------------------------------
int main ( int argc, char *argv[] )
{

    // Processing args.
    if( argc != 2 )
    {
        std::cout << "Please, give the array size!\n";

        return EXIT_FAILURE;
    }

    if( argc == 2 and atol(argv[1]) < 1 )
    {
        std::cout << "Invalid size!\n";

        return EXIT_FAILURE;
    }
    // -------------------------------------------------

    long int size = atol(argv[1]); // Array size.

    long int * arr = gen_array(size); // Generating a random array.
    //print( arr, size ); // printing.
    
    std::chrono::steady_clock::time_point START = std::chrono::steady_clock::now();
    shell( arr, size ); // sorting.
    std::chrono::steady_clock::time_point STOP = std::chrono::steady_clock::now();

    auto timer = (STOP - START);

    double final_time = std::chrono::duration< double > (timer).count();

    //print( arr, size ); // printing after sort.

    delete[] arr; // freeing memory.

    std::cout << std::fixed
              << std::setprecision(3) 
              << final_time << std::endl;
    
    return EXIT_SUCCESS;
}
