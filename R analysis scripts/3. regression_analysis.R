rm(list = ls())
setwd('C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_')
source('2. frequency_analysis.R')

###Logit models estimated using penalised likelihood to limit bias due to data sparsity:
library(logistf)

regression_function = function (datum=wk1_dataset, reasons=NULL, yes_no_outcome =NULL)
{
  if (!is.null(reasons)==T)
  {
    ###Denominator:
    datum$var_denom=NULL
    datum$var_denom[ eval(parse(text=paste0('datum$',reasons,'==1', collapse = '|')))]=1
    datum=subset(datum, var_denom==1)
    eval(parse(text=paste0('model', 1:length(reasons), '=logistf(datum[,"',reasons,'"] ~ datum$gender + datum$age_cat + datum$state_cat + datum$idp_camp + datum$recently_displaced)', sep ='\n')))
    
    eval(parse(text=paste0('names',1:length(reasons),'=names(model',1:length(reasons),'$coefficients)', sep='\n')))
    eval(parse(text=paste0('ORs',1:length(reasons),'=round(exp(model',1:length(reasons),'$coefficients),2)', sep='\n')))
    eval(parse(text=paste0('p_value',1:length(reasons),'=round(model',1:length(reasons),'$prob,3)', sep='\n')))
    all_names=eval(parse(text=paste0('c(',paste0('names',1:length(reasons),collapse=','),')')))
    all_ORs=eval(parse(text=paste0('c(',paste0('ORs',1:length(reasons),collapse=','),')')))
    names(all_ORs)=NULL
    
    all_pvalues=eval(parse(text=paste0('c(',paste0('p_value',1:length(reasons),collapse=','),')')))
    names(all_pvalues)=NULL
    
    reasons_column= paste0(reasons, paste0('cbind(',rep('',length(names1)),')'))
    
    eval(parse(text=paste0('reason_names=c(',paste0('"',reasons,'"', ",'','','','','','','','',''", collapse = ','),')')))
    model_results = cbind(reason_names,all_names, paste0('OR = ',all_ORs, ' (p - value = ',all_pvalues,')'))
    
    colnames(model_results)=c('Reasons','Coefficient','OR (p - value)')
  }
  
  else if (!is.null(reasons)==F)
  {
    datum = subset(datum, datum[,yes_no_outcome]=='yes'|datum[,yes_no_outcome]=='no')
    #datum[,yes_no_outcome][datum[,yes_no_outcome]=='NC'|datum[,yes_no_outcome]=='WS'|datum[,yes_no_outcome]=='NR']=NA
    datum[,yes_no_outcome]=factor(datum[,yes_no_outcome])
    datum[,yes_no_outcome]=relevel(datum[,yes_no_outcome], ref = 'no')
    
    model=logistf(datum[,yes_no_outcome]~ datum$gender + datum$age_cat + datum$state_cat + datum$idp_camp + datum$recently_displaced)
    #model_results=cbind(round(exp(model$coefficients),2),round(exp(sqrt(diag(model$var))),2), round(model$prob,3))
    model_results=cbind( names(model$coefficients), paste0('OR = ',round(exp(model$coefficients),2), ' (p - value = ',round(model$prob,3),')'))
    colnames(model_results)=c('Coefficient','OR (p - value)')
  }
  
  return(model_results)
}

##Calling the regression function:
##Modelling yes/no responses:
q4_yesno_reg=regression_function(datum=wk4_dataset, reasons=NULL, yes_no_outcome ='rqa_s02e04_yes_no_amb')
q5_yesno_reg=regression_function(datum=wk5_dataset, reasons=NULL, yes_no_outcome ='rqa_s02e05_yes_no_amb')
q6_yesno_reg=regression_function(datum=wk6_dataset, reasons=NULL, yes_no_outcome ='rqa_s02e06_yes_no_amb')

qs4_6_reg_results=rbind(cbind('Q 4',''),q4_yesno_reg,cbind('Q 5',''),q5_yesno_reg,cbind('Q 6',''),q6_yesno_reg)




###Modelling reasons:
q1_reasons_reg=regression_function(datum=wk1_dataset, reasons=q1_reasons, yes_no_outcome =NULL)
q2_reasons_reg=regression_function(datum=wk2_dataset, reasons=q2_reasons, yes_no_outcome =NULL)
q3_reasons_reg=regression_function(datum=wk3_dataset, reasons=q3_reasons, yes_no_outcome =NULL)

q1_3_reason_reg_results=rbind(q1_reasons_reg,q2_reasons_reg,q3_reasons_reg)
  
# q4_yes_reasons_reg=regression_function(datum=wk4_dataset[wk4_dataset$rqa_s02e04_yes_no_amb=='yes',], reasons=q4_yes_reasons, yes_no_outcome = NULL)
# q4_no_reasons_reg=regression_function(datum=wk4_dataset[wk4_dataset$rqa_s02e04_yes_no_amb=='no',], reasons=q4_no_reasons, yes_no_outcome = NULL)
# q_5_yes_reasons_reg=regression_function(datum=wk5_dataset[wk5_dataset$rqa_s02e05_yes_no_amb=='yes',], reasons=q5_yes_reasons, yes_no_outcome = NULL)
# q_5_no_reasons_reg=regression_function(datum=wk5_dataset[wk5_dataset$rqa_s02e05_yes_no_amb=='no',], reasons=q5_no_reasons, yes_no_outcome = NULL)
# q_6_yes_reasons_reg=regression_function(datum=wk6_dataset[wk6_dataset$rqa_s02e06_yes_no_amb=='yes',], reasons=q6_yes_reasons, yes_no_outcome = NULL)
# q_6_no_reasons_reg=regression_function(datum=wk6_dataset[wk6_dataset$rqa_s02e06_yes_no_amb=='no',], reasons=q6_no_reasons, yes_no_outcome = NULL)


