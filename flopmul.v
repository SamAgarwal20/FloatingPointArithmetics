module flopmul_special(
    input [31:0] addent,
    input [31:0] augend,
    output reg [31:0] result
);
    reg [7:0] exp1,exp2,exp;
    reg [23:0] frac1,frac2,frac;
    reg [47:0] prod;
    reg sign1,sign2,sign;
    reg cout;
    always @(*)
        begin
             frac1 = {1'b1,addent[22:0]};
                frac2 = {1'b1,augend[22:0]};
                exp1 = addent[30:23];
                exp2 = augend[30:23];
                sign1 = addent[31];
                sign2 = augend[31];
            if(((&exp1)&&(|frac1[22:0]))||((&exp2)&&(|frac2[22:0]))) //if nan 
            begin
                sign = sign1^sign2;
                exp = 8'b11111111; 
                frac = 24'b11111111111111111111111; //assign NaN
                    
            end
            
            else if(~|({exp1,frac1[22:0]})) // check if addent is 0
            begin
                if((&exp2)&&~|(frac2[22:0])) // check if auegnd is infinity
                    begin   
                    sign = sign1^sign2;            
                    exp = 8'b11111111; 
                    frac = 24'b11111111111111111111111; //assign NaN
                    end
                else
                    begin
                    sign = sign1;
                    exp =  8'b0;//assign 0
                    frac = 24'b0;
                    end
            end

            else if(~|({exp2,frac2[22:0]})) // check if audend is 0
            begin
                if((&exp1)||~|(frac1[22:0])) // check if addent is infinity
                    begin
                    sign = sign1^sign2;
                    exp = 8'b11111111; 
                    frac = 24'b11111111111111111111111; //assign NaN
                    end
                else
                    begin
                    sign = sign2;
                    exp =  8'b0;//assign 0
                    frac = 24'b0;
                    end
            end
            
            else if(((&exp1)||~|(frac1[22:0]))||((&exp2)||~|(frac2[22:0]))) //if infinity
            begin
                    sign = sign1^sign2; // assign infinity or -infinity
                    exp = 8'd255;
                    frac = 24'b0;

            end
            else
                begin
                sign = sign1^sign2;
                exp = exp1 + exp2 - 127;
                prod = frac1*frac2;
                {cout,frac} = prod[47:23];
                if(cout)
                begin
                    frac = {cout,frac[23:1]};
                    exp = exp+1;
                end
                end
                result = {sign,exp,frac[22:0]};
                    
        end
endmodule
