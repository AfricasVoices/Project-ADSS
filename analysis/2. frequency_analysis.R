rm(list = ls())
args = commandArgs(trailingOnly=TRUE)

# TODO: Switch to use opt-parse?
if (length(args) < 2) {
  stop("not enough args!", call.=FALSE)
}

working_dir = args[1]
cleaned_input_dir = args[2]

setwd(working_dir)

###Reading the cleaned datasets into workspace:
eval(parse(text=paste0(c('wk1_dataset','wk2_dataset','wk3_dataset','wk4_dataset','wk5_dataset','wk6_dataset','merged_data'),
       sprintf('= read.csv("%s/', cleaned_input_dir),
       c('cleaned_wk1_dataset','cleaned_wk2_dataset','cleaned_wk3_dataset','cleaned_wk4_dataset','cleaned_wk5_dataset','cleaned_wk6_dataset','merged_cleaned_data'),
       '.csv")', sep = '\n')))

#################A:-------------Participation analysis across the six weeks---------------------------#################################
wk1=table(merged_data$radio_participation_s02e01=='true' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
            merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk2=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='true'& merged_data$radio_participation_s02e03=='false' &
            merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk3=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='true' &
            merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk4=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
            merged_data$radio_participation_s02e04=='true' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk5=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
            merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='true'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk6=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
            merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='true')['TRUE']

wk1_2=table(merged_data$radio_participation_s02e01=='true' & merged_data$radio_participation_s02e02=='true'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk1_3=table(merged_data$radio_participation_s02e01=='true' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='true' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk1_4=table(merged_data$radio_participation_s02e01=='true' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='true' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk1_5=table(merged_data$radio_participation_s02e01=='true' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='true'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk1_6=table(merged_data$radio_participation_s02e01=='true' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='true')['TRUE']

wk2_3=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='true'& merged_data$radio_participation_s02e03=='true' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk2_4=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='true'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='true' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk2_5=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='true'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='true'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk2_6=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='true'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='true')['TRUE']

wk3_4=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='true' &
              merged_data$radio_participation_s02e04=='true' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk3_5=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='true' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='true'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk3_6=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='true' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='true')['TRUE']

wk4_5=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='true' & merged_data$radio_participation_s02e05=='true'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk4_6=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='true' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='true')['TRUE']

wk5_6=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
              merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='true'& merged_data$radio_participation_s02e06=='true')['TRUE']

noparticipation=table(merged_data$radio_participation_s02e01=='false' & merged_data$radio_participation_s02e02=='false'& merged_data$radio_participation_s02e03=='false' &
                        merged_data$radio_participation_s02e04=='false' & merged_data$radio_participation_s02e05=='false'& merged_data$radio_participation_s02e06=='false')['TRUE']

wk1_6=table(merged_data$radio_participation_s02e01=='true' & merged_data$radio_participation_s02e02=='true'& merged_data$radio_participation_s02e03=='true' &
              merged_data$radio_participation_s02e04=='true' & merged_data$radio_participation_s02e05=='true'& merged_data$radio_participation_s02e06=='true')['TRUE']

participation_results=rbind( c(wk1, wk1_2,wk1_3,wk1_4,wk1_5,wk1_6),
                             c('', wk2,wk2_3,wk2_4,wk2_5,wk2_6),
                             c('', '',wk3,wk3_4,wk3_5,wk3_6),
                             c('', '','',wk4,wk4_5,wk4_6),
                             c('', '','','',wk5,wk5_6),
                             c('', '','','','',wk6))

####Distribution of participants per show regardless of the number of participation:
eval(parse(text=paste0('n_wk',1:6,'=table(wk',1:6,'_dataset$radio_participation_s02e0',1:6,"=='true')['TRUE']", sep ='\n')))

#####Who participated?:
indpt_vars=c('gender','age_cat','state_cat','idp_camp','recently_displaced')
tab_ind_function_across_Qs1_6 = function (var = 'gender')
{
  ##A bit of cleaning:
  merged_data[,var][merged_data[,var]=='STOP'|merged_data[,var]=='WS'|merged_data[,var]=='NC'|merged_data[,var]=='NIC'|merged_data[,var]=='NR']=NA
  merged_data[,var]=factor(merged_data[,var])
  n_tab=table(merged_data[,var])
  prop_tab=round(prop.table(table(merged_data[,var]))*100,1)
  lab = c(var, rep('',length(levels(merged_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

demographic_characteristics=do.call('rbind',sapply(indpt_vars, tab_ind_function_across_Qs1_6))


###---------------------------------------Analysis of messages------------------------########################################
###-----------Reasons given in radio show questions 1 - 3:
q1_reasons=setdiff(grep('rqa_s02e01_', names(merged_data), v=T),c("rqa_s02e01_NA" ,"rqa_s02e01_NS","rqa_s02e01_NC",                                        
                                                           "rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS","rqa_s02e01_raw"))

q2_reasons=setdiff(grep('rqa_s02e02_', names(merged_data), v=T),c("rqa_s02e02_NA" ,"rqa_s02e02_NS","rqa_s02e02_NC",                                        
                                                           "rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS","rqa_s02e02_raw"))

q3_reasons=setdiff( grep('rqa_s02e03_', names(merged_data), v=T),c("rqa_s02e03_NA" ,"rqa_s02e03_NS","rqa_s02e03_NC",                                        
                                                            "rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS","rqa_s02e03_raw"))

q4_yes_reasons=c("rqa_s02e04_youth_are_the_pillar_of_the_society","rqa_s02e04_youth_are_a_majority_of_the_population",  
                 "rqa_s02e04_youth_are_capable","rqa_s02e04_youth_are_the_future","rqa_s02e04_youth_are_citizens_of_the_country","rqa_s02e04_yes_other")
q4_no_reasons=c("rqa_s02e04_youth_are_immature","rqa_s02e04_substance_abuse_among_youth","rqa_s02e04_decision_making_is_for_leaders_and_elders","rqa_s02e04_youth_are_incapable",
                "rqa_s02e04_youth_are_discriminated_against","rqa_s02e04_youth_are_part_of_the_problem","rqa_s02e04_no_other")

q5_yes_reasons=c("rqa_s02e05_provide_education_for_the_most_vulnerable","rqa_s02e05_education_support_from_NGOs_is_beneficial",                     
                 "rqa_s02e05_education_is_important","rqa_s02e05_provision_of_quality_education","rqa_s02e05_weak_governance","rqa_s02e05_yes_other")
q5_no_reasons=c("rqa_s02e05_lacks_quality","rqa_s02e05_education_services_not_sufficient","rqa_s02e05_creates_aid_dependency","rqa_s02e05_erodes_culture_and_religion",
                "rqa_s02e05_corruption","rqa_s02e05_aid_agencies_unjust","rqa_s02e05_lack_of_monitoring","rqa_s02e05_not_sustainable",
                "rqa_s02e05_not_aware_of_education_services_provided_by_aid_organisations","rqa_s02e05_no_other")

q6_yes_reasons=c("rqa_s02e06_part_of_the_society","rqa_s02e06_majority_of_the_population","rqa_s02e06_religion",                   
                 "rqa_s02e06_it_is_their_right","rqa_s02e06_have_knowledge","rqa_s02e06_yes_other")
q6_no_reasons=c("rqa_s02e06_not_part_of_the_society","rqa_s02e06_the_IDPs_isolate_themselves","rqa_s02e06_they_are_discriminated","rqa_s02e06_lack_knowledge",
                "rqa_s02e06_not_a_priority_for_IDPs","rqa_s02e06_no_other")

###Participant analysis - with at least a relevant messages:

eval(parse(text=paste0('table(',paste0('wk1_dataset$',q1_reasons,'==1', collapse = '|'),')')))['TRUE']/nrow(wk1_dataset)
eval(parse(text=paste0('table(',paste0('wk2_dataset$',q2_reasons,'==1', collapse = '|'),')')))['TRUE']/nrow(wk2_dataset)
eval(parse(text=paste0('table(',paste0('wk3_dataset$',q3_reasons,'==1', collapse = '|'),')')))['TRUE']/nrow(wk3_dataset)

###participants with at least a relevant reason!
table(wk4_dataset$rqa_s02e04_yes_no_amb)[c('yes','no')]
eval(parse(text=paste0("table(wk4_dataset$rqa_s02e04_yes_no_amb=='yes' & (",paste0('wk4_dataset$',q4_yes_reasons,'==1', collapse = '|'),'))')))['TRUE']+
eval(parse(text=paste0("table(wk4_dataset$rqa_s02e04_yes_no_amb=='no' & (",paste0('wk4_dataset$',q4_no_reasons,'==1', collapse = '|'),'))')))['TRUE']

table(wk5_dataset$rqa_s02e05_yes_no_amb)[c('yes','no')]
eval(parse(text=paste0("table(wk5_dataset$rqa_s02e05_yes_no_amb=='yes' & (",paste0('wk5_dataset$',q5_yes_reasons,'==1', collapse = '|'),'))')))['TRUE']+
eval(parse(text=paste0("table(wk5_dataset$rqa_s02e05_yes_no_amb=='no' & (",paste0('wk5_dataset$',q5_no_reasons,'==1', collapse = '|'),'))')))['TRUE']

table(wk6_dataset$rqa_s02e06_yes_no_amb)[c('yes','no')]
(eval(parse(text=paste0("table(wk6_dataset$rqa_s02e06_yes_no_amb=='no' & (",paste0('wk6_dataset$',q6_no_reasons,'==1', collapse = '|'),'))')))['TRUE']+
    eval(parse(text=paste0("table(wk6_dataset$rqa_s02e06_yes_no_amb=='yes' & (",paste0('wk6_dataset$',q6_yes_reasons,'==1', collapse = '|'),'))')))['TRUE'])

###Relevance of messages:

eval(parse(text=paste0('wk1_dataset$',c(q1_reasons,"rqa_s02e01_NS","rqa_s02e01_NC","rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"),'=as.numeric(as.character(',
                       'wk1_dataset$',c(q1_reasons ,"rqa_s02e01_NS","rqa_s02e01_NC","rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('wk1_dataset$',q1_reasons, collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('wk1_dataset$',c(q1_reasons,"rqa_s02e01_NS","rqa_s02e01_NC","rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"), collapse=','),")")))
##
eval(parse(text=paste0('wk2_dataset$',c(q2_reasons,"rqa_s02e02_NS","rqa_s02e02_NC","rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"),'=as.numeric(as.character(',
                       'wk2_dataset$',c(q2_reasons ,"rqa_s02e02_NS","rqa_s02e02_NC","rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('wk2_dataset$',q2_reasons, collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('wk2_dataset$',c(q2_reasons,"rqa_s02e02_NA" ,"rqa_s02e02_NS","rqa_s02e02_NC","rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"), collapse=','),")")))

##
eval(parse(text=paste0('wk3_dataset$',c(q3_reasons ,"rqa_s02e03_NS","rqa_s02e03_NC","rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"),'=as.numeric(as.character(',
                       'wk3_dataset$',c(q3_reasons ,"rqa_s02e03_NS","rqa_s02e03_NC","rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('wk3_dataset$',q3_reasons, collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('wk3_dataset$',c(q3_reasons ,"rqa_s02e03_NS","rqa_s02e03_NC","rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"), collapse=','),")")))

##Q4
eval(parse(text=paste0('wk4_dataset$',c(q4_yes_reasons,q4_no_reasons,"rqa_s02e04_NS","rqa_s02e04_NC","rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"),'=as.numeric(as.character(',
                       'wk4_dataset$',c(q4_yes_reasons,q4_no_reasons,"rqa_s02e04_NS","rqa_s02e04_NC","rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('wk4_dataset$',c(q4_yes_reasons,q4_no_reasons), collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('wk4_dataset$',c(q4_yes_reasons,q4_no_reasons ,"rqa_s02e04_NS","rqa_s02e04_NC","rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"), collapse=','),")")))

##Q 5

eval(parse(text=paste0('wk5_dataset$',c(q5_yes_reasons,q5_no_reasons,"rqa_s02e05_NS","rqa_s02e05_NC","rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"),'=as.numeric(as.character(',
                       'wk5_dataset$',c(q5_yes_reasons,q5_no_reasons,"rqa_s02e05_NS","rqa_s02e05_NC","rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('wk5_dataset$',c(q5_yes_reasons,q5_no_reasons), collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('wk5_dataset$',c(q5_yes_reasons,q5_no_reasons,"rqa_s02e05_NS","rqa_s02e05_NC","rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"), collapse=','),")")))

##Q 6
eval(parse(text=paste0('wk6_dataset$',c(q6_yes_reasons,q6_no_reasons,"rqa_s02e06_NS","rqa_s02e06_NC","rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"),'=as.numeric(as.character(',
                       'wk6_dataset$',c(q6_yes_reasons,q6_no_reasons,"rqa_s02e06_NS","rqa_s02e06_NC","rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('wk6_dataset$',c(q6_yes_reasons,q6_no_reasons), collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('wk6_dataset$',c(q6_yes_reasons,q6_no_reasons,"rqa_s02e06_NS","rqa_s02e06_NC","rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"), collapse=','),")")))

###Relevance of yes/no in question 4 - 6:

sum(table(wk4_dataset$rqa_s02e04_yes_no_amb)[c('yes','no')])
sum(table(wk4_dataset$rqa_s02e04_yes_no_amb))

sum(table(wk5_dataset$rqa_s02e05_yes_no_amb)[c('yes','no')])
sum(table(wk5_dataset$rqa_s02e05_yes_no_amb))

sum(table(wk6_dataset$rqa_s02e06_yes_no_amb)[c('yes','no')])
sum(table(wk6_dataset$rqa_s02e06_yes_no_amb))

tab_function = function (datum = wk1_dataset, variables = q1_reasons, main_q = NULL, strat_var=NULL, reason_Q=NULL, demog_var=NULL, demog_level=NULL)
{
  if (!is.null(demog_var)==T)
  {
  datum = subset (datum, datum[,demog_var]== demog_level)
  }
  
  else if (!is.null(demog_var)==F)
  {
    datum = datum
  }
  
  if (!is.null(main_q)==T)
  {
    datum = subset (datum, datum[,main_q]== strat_var)
    ###Denominator:
    datum$var_denom=NULL
    datum$var_denom[ eval(parse(text=paste0('datum$',variables,'==1', collapse = '|')))]=1
    denom=length(na.omit(datum$var_denom))
    lab =c (paste0(main_q,' - ',strat_var,' reasons'), rep('',length(variables)-1))
  }
  
  else if (!is.null(main_q)==F)
  {
    datum = datum
    ###Denominator:
    datum$var_denom=NULL
    datum$var_denom[ eval(parse(text=paste0('datum$',variables,'==1', collapse = '|')))]=1
    denom=length(na.omit(datum$var_denom))
    lab =c (paste0(reason_Q, ' reasons'), rep('',length(variables)-1))
  }
  
  eval(parse(text=paste0('n_res',1:length(variables),'= table(datum$',variables,') ["1"]', sep = '\n')))
  eval(parse(text=paste0('prop_res',1:length(variables),'= round(((table(datum$',variables,') ["1"]/denom)*100) ["1"],1)', sep = '\n')))
  
  all_n_res=eval(parse(text=paste0('c(',paste0('n_res',1:length(variables),collapse = ','),')')))
  all_n_res[is.na(all_n_res)]=0
  all_prop_res=eval(parse(text=paste0('c(',paste0('prop_res',1:length(variables),collapse = ','),')')))
  all_prop_res[is.na(all_prop_res)]=0
  all_n_prop_res=cbind(c('',lab),c('',variables),c(paste0('n = ', denom),paste0(all_n_res, ' (',all_prop_res,'%)')))
  colnames(all_n_prop_res)=c('Question','Variables', 'n (%)')
  return (all_n_prop_res)
}

###Calling the tabulation function

##Disaggregation by demographic data: gender, age_cat, state,idp_camp, recently_displaced)
##Further cleaning of demographic data:
eval(parse(text=paste0('wk',1:6,'_dataset$gender[wk',1:6,'_dataset$gender=="NC"|wk',1:6,'_dataset$gender=="WS"]=NA', sep ="\n")))
eval(parse(text=paste0('wk',1:6,'_dataset$age_cat[wk',1:6,'_dataset$age_cat=="NC"|wk',1:6,'_dataset$age_cat=="WS"]=NA', sep ="\n")))
eval(parse(text=paste0('wk',1:6,'_dataset$state[wk',1:6,'_dataset$state=="NC"|wk',1:6,'_dataset$state=="NR"|wk',1:6,'_dataset$state=="NIC"|wk',1:6,'_dataset$state=="WS"',']=NA', sep ="\n")))
eval(parse(text=paste0('wk',1:6,'_dataset$recently_displaced[wk',1:6,'_dataset$recently_displaced=="NC"|wk',1:6,'_dataset$recently_displaced=="NR"|wk',1:6,'_dataset$recently_displaced=="WS"',']=NA', sep ="\n")))
eval(parse(text=paste0('wk',1:6,'_dataset$idp_camp[wk',1:6,'_dataset$idp_camp=="NC"|wk',1:6,'_dataset$idp_camp=="NR"|wk',1:6,'_dataset$idp_camp=="WS"',']=NA', sep ="\n")))

##Factor reconversion to completely exclude non relevant levels:
eval(parse(text=paste0('wk',1:6,'_dataset$gender=factor(wk',1:6,'_dataset$gender)', sep='\n')))
eval(parse(text=paste0('wk',1:6,'_dataset$age_cat=factor(wk',1:6,'_dataset$age_cat)', sep='\n')))
eval(parse(text=paste0('wk',1:6,'_dataset$state=factor(wk',1:6,'_dataset$state)', sep='\n')))
eval(parse(text=paste0('wk',1:6,'_dataset$recently_displaced=factor(wk',1:6,'_dataset$recently_displaced)', sep='\n')))
eval(parse(text=paste0('wk',1:6,'_dataset$idp_camp=factor(wk',1:6,'_dataset$idp_camp)', sep='\n')))

##Question 1 reasons:
total_msgs_q1=cbind(
  tab_function (datum = wk1_dataset, variables = q1_reasons, reason_Q='Q 1'),
  tab_function (datum = wk1_dataset[wk1_dataset$gender=='female',], variables = q1_reasons, reason_Q='Q 1', demog_var='gender', demog_level='female')[,3],
  
  tab_function (datum = wk1_dataset[wk1_dataset$gender=='male',], variables = q1_reasons, reason_Q='Q 1', demog_var='gender', demog_level='male')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$age_cat=='<=18',], variables = q1_reasons, reason_Q='Q 1', demog_var='age_cat', demog_level='<=18')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$age_cat=='>18 and <=25',], variables = q1_reasons, reason_Q='Q 1', demog_var='age_cat', demog_level='>18 and <=25')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$age_cat=='>25 and <=35',], variables = q1_reasons, reason_Q='Q 1', demog_var='age_cat', demog_level='>25 and <=35')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$age_cat=='>35',], variables = q1_reasons, reason_Q='Q 1', demog_var='age_cat', demog_level='>35')[,3],
  
  tab_function (datum = wk1_dataset[wk1_dataset$state_cat=='Banadir',], variables = q1_reasons, reason_Q='Q 1', demog_var='state_cat', demog_level='Banadir')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$state_cat=='EFS',], variables = q1_reasons, reason_Q='Q 1', demog_var='state_cat', demog_level='EFS')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$state_cat=='Puntland',], variables = q1_reasons, reason_Q='Q 1', demog_var='state_cat', demog_level='Puntland')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$state_cat=='Somaliland',], variables = q1_reasons, reason_Q='Q 1', demog_var='state_cat', demog_level='Somaliland')[,3],
  
  tab_function (datum = wk1_dataset[wk1_dataset$recently_displaced=='yes',], variables = q1_reasons, reason_Q='Q 1', demog_var='recently_displaced', demog_level='yes')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$recently_displaced=='no',], variables = q1_reasons, reason_Q='Q 1', demog_var='recently_displaced', demog_level='no')[,3],
  
  tab_function (datum = wk1_dataset[wk1_dataset$idp_camp=='yes',], variables = q1_reasons, reason_Q='Q 1', demog_var='idp_camp', demog_level='yes')[,3],
  tab_function (datum = wk1_dataset[wk1_dataset$idp_camp=='no',], variables = q1_reasons, reason_Q='Q 1', demog_var='idp_camp', demog_level='no')[,3]
)

output_column_labels=c('Question','Variables','Total','Female','Male','<= 18 years','>18 and <=25 years','>25 and <=35 years','>35',
                       'Banadir','EFS','Puntland','Somaliland', 'Recently displaced (yes)','Recently displaced (no)','idp camp (yes)','idp camp (no)')
colnames(total_msgs_q1)=output_column_labels

##Question 2 reasons:
total_msgs_q2=cbind(
  tab_function (datum = wk2_dataset, variables = q2_reasons, reason_Q='Q 2'),
  tab_function (datum = wk2_dataset[wk2_dataset$gender=='female',], variables = q2_reasons, reason_Q='Q 2', demog_var='gender', demog_level='female')[,3],
  
  tab_function (datum = wk2_dataset[wk2_dataset$gender=='male',], variables = q2_reasons, reason_Q='Q 2', demog_var='gender', demog_level='male')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$age_cat=='<=18',], variables = q2_reasons, reason_Q='Q 2', demog_var='age_cat', demog_level='<=18')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$age_cat=='>18 and <=25',], variables = q2_reasons, reason_Q='Q 2', demog_var='age_cat', demog_level='>18 and <=25')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$age_cat=='>25 and <=35',], variables = q2_reasons, reason_Q='Q 2', demog_var='age_cat', demog_level='>25 and <=35')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$age_cat=='>35',], variables = q2_reasons, reason_Q='Q 2', demog_var='age_cat', demog_level='>35')[,3],
  
  tab_function (datum = wk2_dataset[wk2_dataset$state_cat=='Banadir',], variables = q2_reasons, reason_Q='Q 2', demog_var='state_cat', demog_level='Banadir')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$state_cat=='EFS',], variables = q2_reasons, reason_Q='Q 2', demog_var='state_cat', demog_level='EFS')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$state_cat=='Puntland',], variables = q2_reasons, reason_Q='Q 2', demog_var='state_cat', demog_level='Puntland')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$state_cat=='Somaliland',], variables = q2_reasons, reason_Q='Q 2', demog_var='state_cat', demog_level='Somaliland')[,3],
  
  tab_function (datum = wk2_dataset[wk2_dataset$recently_displaced=='yes',], variables = q2_reasons, reason_Q='Q 2', demog_var='recently_displaced', demog_level='yes')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$recently_displaced=='no',], variables = q2_reasons, reason_Q='Q 2', demog_var='recently_displaced', demog_level='no')[,3],
  
  tab_function (datum = wk2_dataset[wk2_dataset$idp_camp=='yes',], variables = q2_reasons, reason_Q='Q 2', demog_var='idp_camp', demog_level='yes')[,3],
  tab_function (datum = wk2_dataset[wk2_dataset$idp_camp=='no',], variables = q2_reasons, reason_Q='Q 2', demog_var='idp_camp', demog_level='no')[,3]
)

colnames(total_msgs_q2)=output_column_labels

##Question 3 reasons:
total_msgs_q3=cbind(
  tab_function (datum = wk3_dataset, variables = q3_reasons, reason_Q='Q 3'),
  tab_function (datum = wk3_dataset[wk3_dataset$gender=='female',], variables = q3_reasons, reason_Q='Q 3', demog_var='gender', demog_level='female')[,3],
  
  tab_function (datum = wk3_dataset[wk3_dataset$gender=='male',], variables = q3_reasons, reason_Q='Q 3', demog_var='gender', demog_level='male')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$age_cat=='<=18',], variables = q3_reasons, reason_Q='Q 3', demog_var='age_cat', demog_level='<=18')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$age_cat=='>18 and <=25',], variables = q3_reasons, reason_Q='Q 3', demog_var='age_cat', demog_level='>18 and <=25')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$age_cat=='>25 and <=35',], variables = q3_reasons, reason_Q='Q 3', demog_var='age_cat', demog_level='>25 and <=35')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$age_cat=='>35',], variables = q3_reasons, reason_Q='Q 3', demog_var='age_cat', demog_level='>35')[,3],
  
  tab_function (datum = wk3_dataset[wk3_dataset$state_cat=='Banadir',], variables = q3_reasons, reason_Q='Q 3', demog_var='state_cat', demog_level='Banadir')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$state_cat=='EFS',], variables = q3_reasons, reason_Q='Q 3', demog_var='state_cat', demog_level='EFS')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$state_cat=='Puntland',], variables = q3_reasons, reason_Q='Q 3', demog_var='state_cat', demog_level='Puntland')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$state_cat=='Somaliland',], variables = q3_reasons, reason_Q='Q 3', demog_var='state_cat', demog_level='Somaliland')[,3],
  
  tab_function (datum = wk3_dataset[wk3_dataset$recently_displaced=='yes',], variables = q3_reasons, reason_Q='Q 3', demog_var='recently_displaced', demog_level='yes')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$recently_displaced=='no',], variables = q3_reasons, reason_Q='Q 3', demog_var='recently_displaced', demog_level='no')[,3],
  
  tab_function (datum = wk3_dataset[wk3_dataset$idp_camp=='yes',], variables = q3_reasons, reason_Q='Q 3', demog_var='idp_camp', demog_level='yes')[,3],
  tab_function (datum = wk3_dataset[wk3_dataset$idp_camp=='no',], variables = q3_reasons, reason_Q='Q 3', demog_var='idp_camp', demog_level='no')[,3]
)

colnames(total_msgs_q3)=output_column_labels

###Question 4 reasons:
total_msgs_q4_yes=cbind(
  tab_function (datum = wk4_dataset, variables = q4_yes_reasons, reason_Q='Q 4 - yes', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes'),
  tab_function (datum = wk4_dataset[wk4_dataset$gender=='female',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='gender', demog_level='female', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$gender=='male',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='gender', demog_level='male', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='<=18',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='age_cat', demog_level='<=18', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='>18 and <=25',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='age_cat', demog_level='>18 and <=25', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='>25 and <=35',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='age_cat', demog_level='>25 and <=35', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='>35',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='age_cat', demog_level='>35', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='Banadir',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='state_cat', demog_level='Banadir', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='EFS',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='state_cat', demog_level='EFS', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='Puntland',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='state_cat', demog_level='Puntland', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='Somaliland',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='state_cat', demog_level='Somaliland', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$recently_displaced=='yes',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='recently_displaced', demog_level='yes', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$recently_displaced=='no',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='recently_displaced', demog_level='no', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$idp_camp=='yes',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='idp_camp', demog_level='yes', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$idp_camp=='no',], variables = q4_yes_reasons, reason_Q='Q 4 = yes' , demog_var='idp_camp', demog_level='no', main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes')[,3]
)

colnames(total_msgs_q4_yes)=output_column_labels

total_msgs_q4_no=cbind(
  tab_function (datum = wk4_dataset, variables = q4_no_reasons, reason_Q='Q 4 - no', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no'),
  tab_function (datum = wk4_dataset[wk4_dataset$gender=='female',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='gender', demog_level='female', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$gender=='male',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='gender', demog_level='male', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='<=18',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='age_cat', demog_level='<=18', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='>18 and <=25',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='age_cat', demog_level='>18 and <=25', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='>25 and <=35',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='age_cat', demog_level='>25 and <=35', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$age_cat=='>35',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='age_cat', demog_level='>35', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='Banadir',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='state_cat', demog_level='Banadir', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='EFS',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='state_cat', demog_level='EFS', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='Puntland',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='state_cat', demog_level='Puntland', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$state_cat=='Somaliland',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='state_cat', demog_level='Somaliland', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$recently_displaced=='yes',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='recently_displaced', demog_level='yes', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$recently_displaced=='no',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='recently_displaced', demog_level='no', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk4_dataset[wk4_dataset$idp_camp=='yes',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='idp_camp', demog_level='yes', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk4_dataset[wk4_dataset$idp_camp=='no',], variables = q4_no_reasons, reason_Q='Q 4 = no' , demog_var='idp_camp', demog_level='no', main_q = 'rqa_s02e04_yes_no_amb', strat_var='no')[,3]
)

colnames(total_msgs_q4_no)=output_column_labels

###Q 5 reasons
###Question 5 reasons:
total_msgs_q5_yes=cbind(
  tab_function (datum = wk5_dataset, variables = q5_yes_reasons, reason_Q='Q 5 - yes', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes'),
  tab_function (datum = wk5_dataset[wk5_dataset$gender=='female',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='gender', demog_level='female', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$gender=='male',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='gender', demog_level='male', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='<=18',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='age_cat', demog_level='<=18', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='>18 and <=25',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='age_cat', demog_level='>18 and <=25', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='>25 and <=35',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='age_cat', demog_level='>25 and <=35', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='>35',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='age_cat', demog_level='>35', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='Banadir',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='state_cat', demog_level='Banadir', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='EFS',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='state_cat', demog_level='EFS', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='Puntland',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='state_cat', demog_level='Puntland', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='Somaliland',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='state_cat', demog_level='Somaliland', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$recently_displaced=='yes',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='recently_displaced', demog_level='yes', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$recently_displaced=='no',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='recently_displaced', demog_level='no', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$idp_camp=='yes',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='idp_camp', demog_level='yes', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$idp_camp=='no',], variables = q5_yes_reasons, reason_Q='Q 5 = yes' , demog_var='idp_camp', demog_level='no', main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes')[,3]
)

colnames(total_msgs_q5_yes)=output_column_labels

total_msgs_q5_no=cbind(
  tab_function (datum = wk5_dataset, variables = q5_no_reasons, reason_Q='Q 5 - no', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no'),
  tab_function (datum = wk5_dataset[wk5_dataset$gender=='female',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='gender', demog_level='female', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$gender=='male',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='gender', demog_level='male', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='<=18',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='age_cat', demog_level='<=18', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='>18 and <=25',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='age_cat', demog_level='>18 and <=25', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='>25 and <=35',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='age_cat', demog_level='>25 and <=35', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$age_cat=='>35',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='age_cat', demog_level='>35', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='Banadir',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='state_cat', demog_level='Banadir', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='EFS',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='state_cat', demog_level='EFS', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='Puntland',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='state_cat', demog_level='Puntland', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$state_cat=='Somaliland',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='state_cat', demog_level='Somaliland', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$recently_displaced=='yes',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='recently_displaced', demog_level='yes', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$recently_displaced=='no',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='recently_displaced', demog_level='no', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk5_dataset[wk5_dataset$idp_camp=='yes',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='idp_camp', demog_level='yes', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk5_dataset[wk5_dataset$idp_camp=='no',], variables = q5_no_reasons, reason_Q='Q 5 = no' , demog_var='idp_camp', demog_level='no', main_q = 'rqa_s02e05_yes_no_amb', strat_var='no')[,3]
)

colnames(total_msgs_q5_no)=output_column_labels

####Q 6 reasons:
###Question 5 reasons:
total_msgs_q6_yes=cbind(
  tab_function (datum = wk6_dataset, variables = q6_yes_reasons, reason_Q='Q 6 - yes', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes'),
  tab_function (datum = wk6_dataset[wk6_dataset$gender=='female',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='gender', demog_level='female', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$gender=='male',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='gender', demog_level='male', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='<=18',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='age_cat', demog_level='<=18', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='>18 and <=25',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='age_cat', demog_level='>18 and <=25', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='>25 and <=35',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='age_cat', demog_level='>25 and <=35', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='>35',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='age_cat', demog_level='>35', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='Banadir',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='state_cat', demog_level='Banadir', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='EFS',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='state_cat', demog_level='EFS', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='Puntland',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='state_cat', demog_level='Puntland', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='Somaliland',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='state_cat', demog_level='Somaliland', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$recently_displaced=='yes',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='recently_displaced', demog_level='yes', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$recently_displaced=='no',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='recently_displaced', demog_level='no', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$idp_camp=='yes',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='idp_camp', demog_level='yes', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$idp_camp=='no',], variables = q6_yes_reasons, reason_Q='Q 6 = yes' , demog_var='idp_camp', demog_level='no', main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes')[,3]
)

colnames(total_msgs_q6_yes)=output_column_labels

total_msgs_q6_no=cbind(
  tab_function (datum = wk6_dataset, variables = q6_no_reasons, reason_Q='Q 6 - no', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no'),
  tab_function (datum = wk6_dataset[wk6_dataset$gender=='female',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='gender', demog_level='female', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$gender=='male',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='gender', demog_level='male', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='<=18',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='age_cat', demog_level='<=18', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='>18 and <=25',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='age_cat', demog_level='>18 and <=25', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='>25 and <=35',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='age_cat', demog_level='>25 and <=35', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$age_cat=='>35',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='age_cat', demog_level='>35', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='Banadir',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='state_cat', demog_level='Banadir', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='EFS',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='state_cat', demog_level='EFS', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='Puntland',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='state_cat', demog_level='Puntland', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$state_cat=='Somaliland',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='state_cat', demog_level='Somaliland', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$recently_displaced=='yes',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='recently_displaced', demog_level='yes', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$recently_displaced=='no',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='recently_displaced', demog_level='no', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  
  tab_function (datum = wk6_dataset[wk6_dataset$idp_camp=='yes',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='idp_camp', demog_level='yes', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3],
  tab_function (datum = wk6_dataset[wk6_dataset$idp_camp=='no',], variables = q6_no_reasons, reason_Q='Q 6 = no' , demog_var='idp_camp', demog_level='no', main_q = 'rqa_s02e06_yes_no_amb', strat_var='no')[,3]
)

colnames(total_msgs_q6_no)=output_column_labels

q1_6_msg_dist=rbind(total_msgs_q1,total_msgs_q2,total_msgs_q3,total_msgs_q4_yes,total_msgs_q4_no,total_msgs_q5_yes,total_msgs_q5_no,total_msgs_q6_yes,total_msgs_q6_no)


###########------------------Analysis of yes/no answers - Qs 4 - 6:
#indpt_vars=c('gender','age_cat','state_cat','idp_camp','recently_displaced')

tab_freq_function = function (datum = wk4_dataset, var = 'rqa_s02e04_yes_no_amb')
{
  datum[,var][datum[,var]=='NC'|datum[,var]=='WS']=NA
  datum[,var]=factor(datum[,var])
  
  n_gender=table(datum$gender, datum[,var])
  gender_row_p=round(prop.table(table(datum$gender, datum[,var]),1)*100)
  gender_column_p=round(prop.table(table(datum$gender, datum[,var]),2)*100)
  
  n_age=table(datum$age_cat, datum[,var])
  age_row_p=round(prop.table(table(datum$age_cat, datum[,var]),1)*100)
  age_column_p=round(prop.table(table(datum$age_cat, datum[,var]),2)*100)
  
  n_state=table(datum$state_cat, datum[,var])
  state_row_p=round(prop.table(table(datum$state_cat, datum[,var]),1)*100)
  state_column_p=round(prop.table(table(datum$state_cat, datum[,var]),2)*100)
  
  n_idp=table(datum$idp_camp, datum[,var])
  idp_row_p=round(prop.table(table(datum$idp_camp, datum[,var]),1)*100)
  idp_column_p=round(prop.table(table(datum$idp_camp, datum[,var]),2)*100)
  
  n_disp=table(datum$recently_displaced, datum[,var])
  disp_row_p=round(prop.table(table(datum$recently_displaced, datum[,var]),1)*100)
  disp_column_p=round(prop.table(table(datum$recently_displaced, datum[,var]),2)*100)
  
  ####results:
  gender=cbind(n_gender,gender_row_p,gender_column_p)
  age=cbind(n_age,age_row_p,age_column_p)
  state=cbind(n_state,state_row_p,state_column_p)
  idp=cbind(n_idp,idp_row_p,idp_column_p)
  disp=cbind(n_disp,disp_row_p,disp_column_p)
  
  all_freqs=rbind(gender,age,state,idp,disp)
  
  return (all_freqs)
  
}

##Calling the function above:
all_yesno_freqs=rbind(tab_freq_function (datum = wk4_dataset, var = 'rqa_s02e04_yes_no_amb'),
tab_freq_function (datum = wk5_dataset, var = 'rqa_s02e05_yes_no_amb'),
tab_freq_function (datum = wk6_dataset, var = 'rqa_s02e06_yes_no_amb'))


####--------------Other analyses-------------------############
merged_data$gender[merged_data$gender=='NC'|merged_data$gender=='WS'|merged_data$gender=='NR']=NA
merged_data$age_cat[merged_data$age_cat=='NC'|merged_data$age_cat=='WS'|merged_data$age_cat=='NR']=NA
merged_data$gender=factor(merged_data$gender)
merged_data$age_cat=factor(merged_data$age_cat)

table(merged_data$gender, merged_data$age_cat)
round(prop.table(table(merged_data$gender, merged_data$age_cat),2)*100)

merged_data$recently_displaced[merged_data$recently_displaced=='NC'|merged_data$recently_displaced=='NR'|merged_data$recently_displaced=='WS']=NA
merged_data$idp_camp[merged_data$idp_camp=='NC'|merged_data$idp_camp=='NR'|merged_data$idp_camp=='WS']=NA

table(merged_data$recently_displaced, merged_data$idp_camp)
round(prop.table(table(merged_data$recently_displaced, merged_data$idp_camp),2)*100)

##cleaning:
merged_data$state[merged_data$state=='NC'|merged_data$state=='NIC'|merged_data$state=='NR'|merged_data$state=='WS']=NA
merged_data$district[merged_data$district=='NC'|merged_data$district=='NIC'|merged_data$district=='NR'|merged_data$district=='WS']=NA
merged_data$state=factor(merged_data$state)
merged_data$district=factor(merged_data$district)

all_numbers_by_geography=c(table(merged_data$state_cat),
table(merged_data$state),
table(merged_data$district))


####Distribution of IDPs by other demogs:
idp_data=subset(merged_data, idp_camp=='yes')
non_idp_data=subset(merged_data, idp_camp=='no')


indpt_vars_c=c('gender','age_cat','state_cat','recently_displaced')
tab_idp_function = function (var = 'gender')
{
  ##A bit of cleaning:
  idp_data[,var][idp_data[,var]=='STOP'|idp_data[,var]=='WS'|idp_data[,var]=='NC'|idp_data[,var]=='NIC'|idp_data[,var]=='NR']=NA
  idp_data[,var]=factor(idp_data[,var])
  n_tab=table(idp_data[,var])
  prop_tab=round(prop.table(table(idp_data[,var]))*100,1)
  lab = c(var, rep('',length(levels(idp_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

tab_noidp_function = function (var = 'gender')
{
  ##A bit of cleaning:
  non_idp_data[,var][non_idp_data[,var]=='STOP'|non_idp_data[,var]=='WS'|non_idp_data[,var]=='NC'|non_idp_data[,var]=='NIC'|non_idp_data[,var]=='NR']=NA
  non_idp_data[,var]=factor(non_idp_data[,var])
  n_tab=table(non_idp_data[,var])
  prop_tab=round(prop.table(table(non_idp_data[,var]))*100,1)
  lab = c(var, rep('',length(levels(non_idp_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

all_idp_nonidp_results=cbind(do.call('rbind',sapply(indpt_vars_c, tab_ind_function_across_Qs1_6)),
                         do.call('rbind',sapply(indpt_vars_c, tab_idp_function)),
                         do.call('rbind',sapply(indpt_vars_c, tab_noidp_function)))


