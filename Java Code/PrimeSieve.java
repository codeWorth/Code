public class PrimeSieve{
	public static void main (String[] args){
		int limit = 10000000;
		int[] primes = new int[limit];

		for(int i = 0; i < limit; i++){
			primes[i] = i;
		}

		int primeToPrint = 0;

		int i = 2;
		while (i < limit){
			if (primes[i] != 0){
				primeToPrint = i;
				for (int j = 2*i; j < limit; j+=i){
					primes[j] = 0;
				}
			}
			i++;
		}

		System.out.println(primeToPrint);
	}
}