module FLOPAdder_sub_special(
input [31:0] addent,
input [31:0] augend,
output reg [31:0] result);

reg [23:0] frac1,frac2,frac;
reg [7:0] exp1,exp2,exp;
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
                frac = frac2;
                exp = exp2; //result = augend
                sign = sign2;
            end
    else if(~|({exp2,frac2[22:0]})) // check if audend is 0
            begin
                frac = frac1; //result = addent
                exp = exp1;
                sign = sign1;
            end
    else if(((&exp1)||~|(frac1[22:0]))) // check if addent is infinity
    begin
         if((&exp2)||(~|frac2[22:0])) // check if augend is infinity
            if(sign1^sign2) // if infinites are of different sign
                begin
                    sign = 1;
                    exp = 8'b11111111; 
                    frac = 24'b11111111111111111111111; //assign NaN
                end
            else
                begin
                    sign = sign1; // assign infinity or -infinity as per sign of addent and/or augend
                    exp = 8'd255;
                    frac = 24'b0;
                end
        else    //if augend is not infinity
            begin
                sign = sign1; //assign inf or -inf as per sign of addent
                exp = 8'd255;
                frac = 24'b0;
            end
    end
    
    else if(((&exp2)||~|(frac2[22:0]))) // check if augend is infinity
            begin
                sign = sign2; //assign inf or -inf as per sign of addent
                exp = 8'd255;
                frac = 24'b0;
            end
    else
    begin
            if(exp1>exp2)
            begin
                exp = exp1;
                sign = sign1;
                frac2 = frac2>>(exp1-exp2);
            end
            else if(exp2>exp1)
            begin
                exp = exp1;
                sign = sign2;
                frac1 = frac1>>(exp2-exp1);
            end
            else if(frac1>frac2)
            begin
                exp = exp1;
                sign = sign1;
            end
            else
            begin
                exp = exp2;
                sign = sign2;
            end
            if(sign1==sign2)
            begin
                {cout,frac} = frac1+frac2;
                if(cout)
                begin
                    frac = {cout,frac[23:1]};
                    exp = exp+1;
                end
            end
            else
            begin
            frac = (frac1>frac2)?(frac1-frac2):(frac2-frac1);
                    while (!frac[23]) 
                    begin
                        frac = frac<<1;
                        exp = exp-1;
                    end
            end 
    end
            result = {sign,exp,frac[22:0]};
end

endmodule            
