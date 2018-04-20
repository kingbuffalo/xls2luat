# -*- coding: utf-8 -*-
import xlrd
import os
import io
import csv
import sys
import getopt

def xls2csv(excelP,f,path):
    print(f,"begin")
    data=xlrd.open_workbook(excelP+f)
    list = data.sheet_names()
    csvP = path + "csv/"
    listLen = len(list)
    for i in range(0,listLen):
        csvFN = list[i]
        sh = data.sheet_by_index(i)
        if "output_" in csvFN:
            csvFN = csvFN[7:]
            fn = csvP + csvFN + ".csv"
            print("  ",fn)
            # fh = open(fn,"w",-1,"utf8",newline='')windows下需要设置newline=''
            fh = io.open(fn,"w",-1,"utf8")
            # wr = csv.writer(fh,quoting=csv.QUOTE_MINIMAL,lineterminator='\n')
            wr = csv.writer(fh,quoting=csv.QUOTE_MINIMAL,lineterminator='\r\n')
            for row_number in range(sh.nrows):
                rv = sh.row_values(row_number)
                wr.writerow(rv)
            fh.close()

def xlspathfiles2csv(path):
    excelP = path + "excel/"
    list_dirs = os.walk(excelP)
    for root, dirs, files in list_dirs:
        for f in files:
            xls2csv(excelP,f,path)
    csvp = path+"csv/"
    csvlist = os.walk(csvp)
    for root,dirs,files in csvlist:
        allF = ",".join(files)
        os.system("lua main.lua "+path +" "+ allF)

def usage():
    print ('-h help\n' \
            '-p  protject path\n'\
                '  protject目录下包含  excel,csv,luaformat,luat 这四个文件夹\n'\
                '    excel中的为xls文件\n'\
                '    csv中的为csv文件\n'\
                '    luaformat中的为格式化lua输出文件\n'\
                '    luat中的为lua文件\n'\
                '    将xls文件转换成csv文件，再将csv转换成lua table文件')

if __name__ == '__main__':
    try:
        options,args = getopt.getopt(sys.argv[1:],"hp:",)
        for name,v in options:
            if name in ('-h'):
                usage()
            elif name in ('-p'):
                xlspathfiles2csv(v+"/")
            else:
                usage()
    except getopt.GetoptError:
        usage()
