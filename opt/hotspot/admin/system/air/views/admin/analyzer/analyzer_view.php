
                    
<div class="span12">   
 <div class="widget_heading">
	<h4>ประวัติการใช้งานและสถิติการทำงานของ SQUID</h4></div>
    <div class="widget_container">


                            <table class="no-style full">

                                <tbody>
                                 
                                        <tr>
                                        <td>Cache Hits</td>
                                        <td style="width:100%"><div id="progress1" class="progress progress-green"><span style="width: <?=$cache_hit?>%;"><b><?=$cache_hit?>%</b></span></div></td>
                                    </tr>

                                    <tr>
                                        <td>Lastday Hits</td>
                                        <td><div class="progress progress-green"><span style="width: <?=$cache_hit_day?>%;"><b><?=$cache_hit_day?>%</b></span></div></td>
                                    </tr>

                                </tbody>
 
                            </table>

                        
						

                        
					<div class="columns leading">
					
                        <h4>All Used History</h4>

                        <hr />
							
						<div class="panel">
							
						</div>

                            <table id="used_list" class="paginate full">
                                <thead>
                                    <tr style="cursor:pointer;">
										<th width="5px">ลำดับ</th>
										<th width="70px">ชื่อผู้ใช้</th>
										<th width="50px">กลุ่ม</th>
										<th width="120px">เริ่มใช้</th>
                                        <th width="120px">หมดอายุ</th>
										<th width="80px">เวลารวม</th>
										<th width="80px">ข้อมูลรวม</th>
										
                                    </tr>
                                </thead>
								 <tfoot>
									<?php foreach ($pp->result() as $row): ?>
									<tr>
										<td colspan="4">&nbsp;</td>
										<td align="right">รวม</td>
										<td align="center" colspan="2"><?=number_format($row->p,$this->config->item('decimal_places'),$this->config->item('decimal_separator'),$this->config->item('thousands_separator'))?>  <?=$this->config->item('currency_symbol_pdf')?></td>
									</tr>
									<?php endforeach;?>
                                </tfoot>
                                <tbody>
									<tr>
										<td></td>
									</tr>
								</tbody>
                            </table>
						
					</div>
</div></div>