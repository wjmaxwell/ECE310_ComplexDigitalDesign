module lab_005_alarm (
  input alarm_set, alarm_stay,
  input [1:0] doors,
  input [2:0] windows,
  output reg secure, alarm
);

  always @* begin
    if( !alarm_set ) begin
	alarm = 0;
	secure = 0;
    end
    else begin
	if( !alarm_stay & ( windows[0] | windows[1] | windows[2] ) ) begin
	  alarm = 1;
	  secure = 0;
        end
	else begin
	  if( alarm_stay & ( doors[0] | doors[1] | windows[0] | windows[1] | windows[2] ) ) begin
	    alarm = 1;
	    secure = 0;
          end
	  else begin
	    alarm = 0;
	    secure = 1;
          end
        end
    end
  end

endmodule
