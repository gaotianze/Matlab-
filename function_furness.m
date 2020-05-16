function [out_table,out_o,out_d] = function_furness(table_prs,o_prs,d_prs,o_ftr,d_ftr,epsilon)
    %���ߣ�gtz
    input_error=MException('myComponent:inputError','�����OD�����������飡');
%     table_prs=[17.0 7.0 4.0;7.0 38.0 6.0;4.0 5.0 17.0];
%     o_prs=[28;51;26];
%     d_prs=[28;50;27];
%     o_ftr=[38.6;91.9;36.0];
%     d_ftr=[39.3;90.3;36.9];
%     epsilon=0.03;
    [~,n]=size(table_prs);
    
    %�ж������Ƿ�����
    for i=1:n
        if sum(table_prs(i,:))~=o_prs(i,1)
            throwAsCaller(input_error);
        end
    end
    for i=1:n
        if sum(table_prs(:,i))~=d_prs(i,1)
            throwAsCaller(input_error);
        end
    end
    
    if sum(o_prs(:,1))~=sum(d_prs(:,1))
        throwAsCaller(input_error);
    end
    
    if sum(o_ftr(:,1))~=sum(d_ftr(:,1))
        throwAsCaller(input_error);
    end
    
    total_prs=sum(o_prs(:,1));
    total_ftr=sum(d_ftr(:,1));
    
    Fo=1;
    Fd=1;
    
    identifier=1;%Ϊ1ʱ��Fd=1��Ϊ0ʱ��Fo=1��
    exit=0;
    while exit==0
    %��������ϵ������������ϵ��
        switch identifier
            case 1
                for i=1:n
                    Fo=o_ftr(i,1)/o_prs(i,1);
                    table_prs(i,:)=table_prs(i,:)*Fo;
                    o_prs(i,:)=o_prs(i,:)*Fo;
                    total_prs=sum(o_prs(:,1));
                end
                for i=1:n
                    d_prs(i,1)=sum(table_prs(:,i));
                end
                %����������׼
                exit=1;
                for i=1:n
                    index=o_ftr(i,1)/o_prs(i,1);
                    if abs(1-index)>epsilon
                        exit=0;
                    end
                end
                for i=1:n
                    index=d_ftr(i,1)/d_prs(i,1);
                    if abs(1-index)>epsilon
                        exit=0;
                    end
                end
                %%%%%%%%%%%
                Fo=1;
                Fd=1;
                identifier=0;
            case 0
                for i=1:n
                    Fd=d_ftr(i,1)/d_prs(i,1);
                    table_prs(:,i)=table_prs(:,i)*Fd;
                    d_prs(i,:)=d_prs(i,:)*Fd;
                    total_prs=sum(d_prs(:,1));
                end
                for i=1:n
                    o_prs(i,1)=sum(table_prs(i,:));
                end
                %����������׼
                exit=1;
                for i=1:n
                    index=o_ftr(i,1)/o_prs(i,1);
                    if abs(1-index)>epsilon
                        exit=0;
                    end
                end
                for i=1:n
                    index=d_ftr(i,1)/d_prs(i,1);
                    if abs(1-index)>epsilon
                        exit=0;
                    end
                end
                %%%%%%%%%%%
                Fo=1;
                Fd=1;
                identifier=1;
        end
    end
    %�ó����ձ�
    if exit==1
        switch identifier
            case 1
                for i=1:n
                    Fo=o_ftr(i,1)/o_prs(i,1);
                    table_prs(i,:)=table_prs(i,:)*Fo;
                    o_prs(i,:)=o_prs(i,:)*Fo;
                    total_prs=sum(o_prs(:,1));
                end
                for i=1:n
                    d_prs(i,1)=sum(table_prs(:,i));
                end
            case 0
                for i=1:n
                    Fd=d_ftr(i,1)/d_prs(i,1);
                    table_prs(:,i)=table_prs(:,i)*Fd;
                    d_prs(i,:)=d_prs(i,:)*Fd;
                    total_prs=sum(d_prs(:,1));
                end
                for i=1:n
                    o_prs(i,1)=sum(table_prs(i,:));
                end
        end
    end
    out_table=table_prs;
    out_o=o_prs;
    out_d=d_prs;
end
