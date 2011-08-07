class Typo
  # Generates typos for words or phrases. Not exhaustive, but helpful for common misspellings
  # Typo.new('love').all produces an array:
  # ["kove", "pove", "oove", "live", "lkve", "llve", "lpve", "l0ve", "l9ve", "loce", "lobe", "loge", "lofe", "lovw", "lovs", "lovd", "lovr", "lov4", "lov3", "ove", "lov", "lve", "olve", "lvoe", "loev", "llove", "loove", "lovve"]
  # inspired by the PHP5 version written by Scott Horne of Takeshi Media and Web-Professor.net
  
    def initialize(word)
      @keyboard = [
        :q => [ '1', '2', 'w', 'a' ],
        :w => [ 'q', 'a', 's', 'e', '3', '2' ],
        :e => [ 'w', 's', 'd', 'r', '4', '3' ],
        :r => [ 'e', 'd', 'f', 't', '5', '4' ],
        :t => [ 'r', 'f', 'g', 'y', '6', '5' ],	
        :y => [ 't', 'g', 'h', 'u', '7', '6' ],
        :u => [ 'y', 'h', 'j', 'i', '8', '7' ],
        :i => [ 'u', 'j', 'k', 'o', '9', '8' ],
        :o => [ 'i', 'k', 'l', 'p', '0', '9' ],
        :p => [ 'o', 'l', '-', '0' ],
        :a => [ 'z', 's' , 'w', 'q' ],
        :s => [ 'a', 'z', 'x', 'd', 'e', 'w' ],
        :d => [ 's', 'x', 'c', 'f', 'r', 'e' ],
        :f => [ 'd', 'c', 'v', 'g', 't', 'r' ],
        :g => [ 'f', 'v', 'b', 'h', 'y', 't' ],
        :h => [ 'g', 'b', 'n', 'j', 'u', 'y' ],
        :j => [ 'h', 'n', 'm', 'k', 'i', 'u' ],
        :k => [ 'j', 'm', 'l', 'o', 'i' ],
        :l => [ 'k', 'p', 'o' ],
        :z => [ 'x', 's', 'a' ],
        :x => [ 'z', 'c', 'd', 's' ],
        :c => [ 'x', 'v', 'f', 'd' ],
        :v => [ 'c', 'b', 'g', 'f' ],
        :b => [ 'v', 'n', 'h', 'g' ],
        :n => [ 'b', 'm', 'j', 'h' ],
        :m => [ 'n', 'k', 'j' ]
        ]
      @word = word.to_s.downcase
      @typos =[]
    end
    
    def all
            
      wrong_char | one_missed_char | transposed_char | double_char
      
    end
    	
  	def wrong_char
  
  		@word.split("").each do |s|
  		  if @keyboard[0][s.to_sym]
  		    @keyboard[0][s.to_sym].each do |r|
  		      @typos << @word.gsub(s,r) unless @typos.include?(@word.gsub(s,r))
  		    end
  		  end  		  
		  end
		  
  		@typos
  	end
  	
    def one_missed_char
    		
        # Chop the first letter
        @typos << @word.slice(1..-1)
        
        # Chop the last letter
        @typos << @word.slice(0..-2)
        
        # Chop middle Letters
        @word.slice(1..-2).length.times do |i|
          @typos << @word.slice(0..i-1) + @word.slice(i+1..-1) unless i == 0
        end
        
        @typos
    end
    
    def transposed_char

  		@word.length.times do |s|
  		  if s < @word.length-1
  		    w = @word.slice(s..s+1)
    		  r = w.reverse
    		  @typos << @word.gsub(w,r)
		    end
		  end
		  
  		@typos
      
    end
    
    def double_char

  		@word.length.times do |s|
  		  if s < @word.length-1 and s != 0
    		  @typos << @word.slice(0..s-1) + @word.slice(s..s) + @word.slice(s..s) + @word.slice(s+1..-1) 
    		elsif s == 0
    		  @typos << @word.slice(0..0) + @word   		   
    		elsif s== @word.length
    		  @typos << @word +  @word.slice(@word.length-1..@word.length)	   
		    end
		  end
		  
  		@typos      
  		
    end

    
  
end