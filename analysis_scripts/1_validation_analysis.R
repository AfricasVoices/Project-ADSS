rm(list = ls())
setwd('C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_')
data1=read.csv('C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/adss_analysis_outputs/csap_s02_individuals.csv')
table(data1$consent_withdrawn)
##Excluding non - consenters:
data= subset(data1, consent_withdrawn =='false')
###EFS

data$state_cat=NULL
data$state_cat[data$state=='banadir']=1
data$state_cat[data$state=='galmudug'|data$state=='hir-shabelle'|data$state=='jubbaland'|data$state=='south west state']=2
data$state_cat[data$state=='somaliland']=3
data$state_cat[data$state=='puntland']=4

data$state_cat=factor(data$state_cat, levels = 1:4, labels = c('Banadir','EFS','Somaliland','Puntland'))

###Participation Analysis by week:

wk1=table(data$radio_participation_s02e01=='true' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
            data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk2=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='true'& data$radio_participation_s02e03=='false' &
            data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk3=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='true' &
            data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk4=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
            data$radio_participation_s02e04=='true' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk5=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
            data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='true'& data$radio_participation_s02e06=='false')['TRUE']

wk6=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
            data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='true')['TRUE']

wk1_2=table(data$radio_participation_s02e01=='true' & data$radio_participation_s02e02=='true'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk1_3=table(data$radio_participation_s02e01=='true' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='true' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk1_4=table(data$radio_participation_s02e01=='true' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='true' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk1_5=table(data$radio_participation_s02e01=='true' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='true'& data$radio_participation_s02e06=='false')['TRUE']

wk1_6=table(data$radio_participation_s02e01=='true' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='true')['TRUE']

wk2_3=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='true'& data$radio_participation_s02e03=='true' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk2_4=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='true'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='true' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk2_5=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='true'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='true'& data$radio_participation_s02e06=='false')['TRUE']

wk2_6=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='true'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='true')['TRUE']

wk3_4=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='true' &
              data$radio_participation_s02e04=='true' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk3_5=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='true' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='true'& data$radio_participation_s02e06=='false')['TRUE']

wk3_6=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='true' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='true')['TRUE']

wk4_5=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='true' & data$radio_participation_s02e05=='true'& data$radio_participation_s02e06=='false')['TRUE']

wk4_6=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='true' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='true')['TRUE']

wk5_6=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
              data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='true'& data$radio_participation_s02e06=='true')['TRUE']

noparticipation=table(data$radio_participation_s02e01=='false' & data$radio_participation_s02e02=='false'& data$radio_participation_s02e03=='false' &
                        data$radio_participation_s02e04=='false' & data$radio_participation_s02e05=='false'& data$radio_participation_s02e06=='false')['TRUE']

wk1_6=table(data$radio_participation_s02e01=='true' & data$radio_participation_s02e02=='true'& data$radio_participation_s02e03=='true' &
              data$radio_participation_s02e04=='true' & data$radio_participation_s02e05=='true'& data$radio_participation_s02e06=='true')['TRUE']

##Distribution of Operators
table(data$operator, useNA = 'ifany')
round(prop.table(table(data$operator, useNA = 'ifany'))*100)

#####---------Checking duplicates:
table(duplicated(data$uid))

###-----------Reasons given in radio show questions 1 - 3:
q1_reasons=setdiff(grep('rqa_s02e01_', names(data), v=T),c("rqa_s02e01_NA" ,"rqa_s02e01_NS","rqa_s02e01_NC",                                        
                                                           "rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS","rqa_s02e01_raw"))

q2_reasons=setdiff(grep('rqa_s02e02_', names(data), v=T),c("rqa_s02e02_NA" ,"rqa_s02e02_NS","rqa_s02e02_NC",                                        
                                                           "rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS","rqa_s02e02_raw"))

q3_reasons=setdiff( grep('rqa_s02e03_', names(data), v=T),c("rqa_s02e03_NA" ,"rqa_s02e03_NS","rqa_s02e03_NC",                                        
                                                            "rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS","rqa_s02e03_raw"))
###----UIDs specified as participated but no reason/data indicated:
##Q 1:
table(data$radio_participation_s02e01)['TRUE']
table(data$radio_participation_s02e01=='true' & 
        (eval(parse(text=paste0('data$',c("rqa_s02e01_NS","rqa_s02e01_NC",                                        
                                          "rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"),'==0', collapse = '&'))))&
        (eval(parse(text=paste0('data$',q1_reasons,'==0', collapse = '&')))))['TRUE']
##UIDs
wk1_uids_exclude_1=data$uid[(data$radio_participation_s02e01=='true' & 
                               (eval(parse(text=paste0('data$',c("rqa_s02e01_NS","rqa_s02e01_NC",                                        
                                                                 "rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"),'==0', collapse = '&'))))&
                               (eval(parse(text=paste0('data$',q1_reasons,'==0', collapse = '&')))))]


table(data$radio_participation_s02e01)['false']
table(data$radio_participation_s02e01=='false' & 
        (eval(parse(text=paste0('data$',q1_reasons,'==1', collapse = '|')))))['TRUE']

data$uid[(data$radio_participation_s02e01=='false' & 
            (eval(parse(text=paste0('data$',q1_reasons,'==1', collapse = '|')))))]
##Q 2:
table(data$radio_participation_s02e02)['TRUE']
table(data$radio_participation_s02e02=='true' & 
        (eval(parse(text=paste0('data$',c("rqa_s02e02_NS","rqa_s02e02_NC",                                        
                                          "rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"),'==0', collapse = '&'))))&
        (eval(parse(text=paste0('data$',q2_reasons,'==0', collapse = '&')))))['TRUE']
##UID
wk2_uids_exclude_2=data$uid[(data$radio_participation_s02e02=='true' & 
                               (eval(parse(text=paste0('data$',c("rqa_s02e02_NS","rqa_s02e02_NC",                                        
                                                                 "rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"),'==0', collapse = '&'))))&
                               (eval(parse(text=paste0('data$',q2_reasons,'==0', collapse = '&')))))]



table(data$radio_participation_s02e02)['false']
table(data$radio_participation_s02e02=='false' & 
        (eval(parse(text=paste0('data$',q2_reasons,'==1', collapse = '|')))))['TRUE']

data$uid[(data$radio_participation_s02e02=='false' & 
            (eval(parse(text=paste0('data$',q2_reasons,'==1', collapse = '|')))))]
##Q 3:
table(data$radio_participation_s02e03)['TRUE']
table(data$radio_participation_s02e03=='true' & 
        (eval(parse(text=paste0('data$',c("rqa_s02e03_NS","rqa_s02e03_NC",                                        
                                          "rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"),'==0', collapse = '&'))))&
        (eval(parse(text=paste0('data$',q3_reasons,'==0', collapse = '&')))))['TRUE']
##UID
wk3_uids_exclude_3=data$uid[(data$radio_participation_s02e03=='true' & 
                               (eval(parse(text=paste0('data$',c("rqa_s02e03_NS","rqa_s02e03_NC",                                        
                                                                 "rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"),'==0', collapse = '&'))))&
                               (eval(parse(text=paste0('data$',q3_reasons,'==0', collapse = '&')))))]

data$uid[(data$radio_participation_s02e03=='false' & 
            (eval(parse(text=paste0('data$',q3_reasons,'==1', collapse = '|')))))]



##Q 4:

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

######################################################################################
##Q 4
###Inconsistent yes/no answers with reasons given, for instance, if yes response was indicated in Qs 4 - 6, then this section examines IDs in which reason(s) indicative 
##of 'no's are specified:
eval(parse(text=paste0('table(data$rqa_s02e04_yes_no_amb=="yes" & (',paste0('data$',q4_yes_reasons, '==0',collapse = "&"),') & (',paste0('data$',q4_no_reasons, '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e04_yes_no_amb=="no" & (',paste0('data$',q4_no_reasons, '==0',collapse = "&"),') & (',paste0('data$',q4_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']
##IDs
eval(parse(text=paste0('wk4_uids_exclude_4=data$uid[(data$rqa_s02e04_yes_no_amb=="yes" & (',paste0('data$',q4_yes_reasons, '==0',collapse = "&"),') & (',paste0('data$',q4_no_reasons, '==1',collapse = "|"),'))]')))
eval(parse(text=paste0('wk4_uids_exclude_5=data$uid[(data$rqa_s02e04_yes_no_amb=="no" & (',paste0('data$',q4_no_reasons, '==0',collapse = "&"),') & (',paste0('data$',q4_yes_reasons, '==1',collapse = "|"),'))]')))

#write.csv(q1_IDs_yes_needs_associated_no_reasons, file = 'q4_IDs_yes_needs_associated_no_reasons')

##Q 5
eval(parse(text=paste0('table(data$rqa_s02e05_yes_no_amb=="yes" & (',paste0('data$',q5_yes_reasons, '==0',collapse = "&"),') & (',paste0('data$',q5_no_reasons, '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e05_yes_no_amb=="no" & (',paste0('data$',q5_no_reasons, '==0',collapse = "&"),') & (',paste0('data$',q5_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']
##IDs
eval(parse(text=paste0('wk5_uids_exclude_6=data$uid[(data$rqa_s02e05_yes_no_amb=="yes" & (',paste0('data$',q5_yes_reasons, '==0',collapse = "&"),') & (',paste0('data$',q5_no_reasons, '==1',collapse = "|"),'))]')))
eval(parse(text=paste0('wk5_uids_exclude_7=data$uid[(data$rqa_s02e05_yes_no_amb=="no" & (',paste0('data$',q5_no_reasons, '==0',collapse = "&"),') & (',paste0('data$',q5_yes_reasons, '==1',collapse = "|"),'))]')))


#write.csv(q5_IDs_yes_needs_associated_no_reasons, file = 'q5_IDs_yes_needs_associated_no_reasons')

##Q 6:
eval(parse(text=paste0('table(data$rqa_s02e06_yes_no_amb=="yes" & (',paste0('data$',q6_yes_reasons, '==0',collapse = "&"),') & (',paste0('data$',q6_no_reasons, '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e06_yes_no_amb=="no" & (',paste0('data$',q6_no_reasons, '==0',collapse = "&"),') & (',paste0('data$',q6_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']
##IDs
eval(parse(text=paste0('wk6_uids_exclude_8=data$uid[(data$rqa_s02e06_yes_no_amb=="yes" & (',paste0('data$',q6_yes_reasons, '==0',collapse = "&"),') & (',paste0('data$',q6_no_reasons, '==1',collapse = "|"),'))]')))
eval(parse(text=paste0('wk6_uids_exclude_9=data$uid[(data$rqa_s02e06_yes_no_amb=="no" & (',paste0('data$',q6_no_reasons, '==0',collapse = "&"),') & (',paste0('data$',q6_yes_reasons, '==1',collapse = "|"),'))]')))

#write.csv(q6_IDs_yes_needs_associated_no_reasons, file = 'q6_IDs_yes_needs_associated_no_reasons')

##Checking contradicting reasons
eval(parse(text=paste0('table(data$rqa_s02e04_yes_no_amb=="yes" & (',paste0('data$',q4_yes_reasons, '==1',collapse = "|"),') & (',paste0('data$',q4_no_reasons, '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e04_yes_no_amb=="no" & (',paste0('data$',q4_no_reasons, '==1',collapse = "|"),') & (',paste0('data$',q4_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']

eval(parse(text=paste0('table(data$rqa_s02e05_yes_no_amb=="yes" & (',paste0('data$',q5_yes_reasons, '==1',collapse = "|"),') & (',paste0('data$',q5_no_reasons, '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e05_yes_no_amb=="no" & (',paste0('data$',q5_no_reasons, '==1',collapse = "|"),') & (',paste0('data$',q5_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']

eval(parse(text=paste0('table(data$rqa_s02e06_yes_no_amb=="yes" & (',paste0('data$',q6_yes_reasons, '==1',collapse = "|"),') & (',paste0('data$',q6_no_reasons, '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e06_yes_no_amb=="no" & (',paste0('data$',q6_no_reasons, '==1',collapse = "|"),') & (',paste0('data$',q6_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']

##UIDs
eval(parse(text=paste0('wk6_uids_exclude_10=data$uid[(data$rqa_s02e06_yes_no_amb=="no" & (',paste0('data$',q6_no_reasons, '==1',collapse = "|"),') & (',paste0('data$',q6_yes_reasons, '==1',collapse = "|"),'))]')))

###------Questions coded as NC though with valid entries in the reasons' variables:
eval(parse(text=paste0('table(data$rqa_s02e04_yes_no_amb=="NC" & (',paste0('data$',c(q4_no_reasons,q4_yes_reasons), '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e05_yes_no_amb=="NC" & (',paste0('data$',c(q5_no_reasons,q5_yes_reasons), '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(data$rqa_s02e06_yes_no_amb=="NC" & (',paste0('data$',c(q6_no_reasons,q6_yes_reasons), '==1',collapse = "|"),'))')))['TRUE']
##UID
eval(parse(text=paste0('data$uid[(data$rqa_s02e04_yes_no_amb=="NC" & (',paste0('data$',c(q4_no_reasons,q4_yes_reasons), '==1',collapse = "|"),'))]')))

################################################################################################################################
##recoding age:
data$age_t=as.numeric(as.character(data$age))
data$age_cat=NULL
data$age_cat[data$age_t<=18]=1
data$age_cat[data$age_t>18 & data$age_t <= 25]=2
data$age_cat[data$age_t>25 & data$age_t <=35]=3
data$age_cat[data$age_t>35]=4
data$age_cat[data$age=='NC']=5
data$age_cat[data$age=='NR']=6
data$age_cat[data$age=='WS']=7
data$age_cat=factor(data$age_cat, levels = 1:7, labels = c('<=18','>18 and <=25','>25 and <=35','>35','NC','NR','WS'))

##Deriving participation data subsets for the six shows:
q1_data=subset(data, radio_participation_s02e01=='true')
q2_data=subset(data, radio_participation_s02e02=='true')
q3_data=subset(data, radio_participation_s02e03=='true')
q4_data=subset(data, radio_participation_s02e04=='true')
q5_data=subset(data, radio_participation_s02e05=='true')
q6_data=subset(data, radio_participation_s02e06=='true')

###Tabulation of yes/no/ambivalent variables:,"rqa_s02e04_yes_no_amb", "rqa_s02e05_yes_no_amb", "rqa_s02e06_yes_no_amb"
table(q4_data$rqa_s02e04_yes_no_amb)
table(q5_data$rqa_s02e05_yes_no_amb)
table(q6_data$rqa_s02e06_yes_no_amb)


###Tabulation of individual variables:
tab_ind_function1 = function (var = 'gender')
{
  n_tab=table(q1_data[,var], useNA = 'ifany')
  prop_tab=round(prop.table(table(q1_data[,var], useNA = 'ifany'))*100,1)
  
  if (table(is.na(q1_data[,var]))['TRUE']>0 & !is.na(table(is.na(q1_data[,var]))['TRUE'])==T)
  {
    lab = c(var, rep('',length(levels(q1_data[,var]))))
  }
  
  else lab = c(var, rep('',length(levels(q1_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

tab_ind_function2 = function (var = 'gender')
{
  n_tab=table(q2_data[,var], useNA = 'ifany')
  prop_tab=round(prop.table(table(q2_data[,var], useNA = 'ifany'))*100,1)
  
  if (table(is.na(q2_data[,var]))['TRUE']>0 & !is.na(table(is.na(q2_data[,var]))['TRUE'])==T)
  {
    lab = c(var, rep('',length(levels(q2_data[,var]))))
  }
  
  else lab = c(var, rep('',length(levels(q2_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

tab_ind_function3 = function (var = 'gender')
{
  n_tab=table(q3_data[,var], useNA = 'ifany')
  prop_tab=round(prop.table(table(q3_data[,var], useNA = 'ifany'))*100,1)
  
  if (table(is.na(q3_data[,var]))['TRUE']>0 & !is.na(table(is.na(q3_data[,var]))['TRUE'])==T)
  {
    lab = c(var, rep('',length(levels(q3_data[,var]))))
  }
  
  else lab = c(var, rep('',length(levels(q3_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

tab_ind_function4 = function (var = 'gender')
{
  n_tab=table(q4_data[,var], useNA = 'ifany')
  prop_tab=round(prop.table(table(q4_data[,var], useNA = 'ifany'))*100,1)
  
  if (table(is.na(q4_data[,var]))['TRUE']>0 & !is.na(table(is.na(q4_data[,var]))['TRUE'])==T)
  {
    lab = c(var, rep('',length(levels(q4_data[,var]))))
  }
  
  else lab = c(var, rep('',length(levels(q4_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

tab_ind_function5 = function (var = 'gender')
{
  n_tab=table(q5_data[,var], useNA = 'ifany')
  prop_tab=round(prop.table(table(q5_data[,var], useNA = 'ifany'))*100,1)
  
  if (table(is.na(q5_data[,var]))['TRUE']>0 & !is.na(table(is.na(q5_data[,var]))['TRUE'])==T)
  {
    lab = c(var, rep('',length(levels(q5_data[,var]))))
  }
  
  else lab = c(var, rep('',length(levels(q5_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

tab_ind_function6 = function (var = 'gender')
{
  n_tab=table(q6_data[,var], useNA = 'ifany')
  prop_tab=round(prop.table(table(q6_data[,var], useNA = 'ifany'))*100,1)
  
  if (table(is.na(q6_data[,var]))['TRUE']>0 & !is.na(table(is.na(q6_data[,var]))['TRUE'])==T)
  {
    lab = c(var, rep('',length(levels(q6_data[,var]))))
  }
  
  else lab = c(var, rep('',length(levels(q6_data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}

tab_ind_function_all = function (var = 'gender')
{
  n_tab=table(data[,var], useNA = 'ifany')
  prop_tab=round(prop.table(table(data[,var], useNA = 'ifany'))*100,1)
  
  if (table(is.na(data[,var]))['TRUE']>0 & !is.na(table(is.na(data[,var]))['TRUE'])==T)
  {
    lab = c(var, rep('',length(levels(data[,var]))))
  }
  
  else lab = c(var, rep('',length(levels(data[,var]))-1))
  count_prop=cbind(lab,n_tab,prop_tab)
  return (count_prop)
}
ind_vars=c('gender','age_cat','district','region','state','zone','idp_camp','recently_displaced','household_language','operator')

###---------------calling the tab_ind_function function
ind_vars_freqs1=do.call('rbind',sapply(ind_vars, tab_ind_function1))
ind_vars_freqs2=do.call('rbind',sapply(ind_vars, tab_ind_function2))
ind_vars_freqs3=do.call('rbind',sapply(ind_vars, tab_ind_function3))
ind_vars_freqs4=do.call('rbind',sapply(ind_vars, tab_ind_function4))
ind_vars_freqs5=do.call('rbind',sapply(ind_vars, tab_ind_function5))
ind_vars_freqs6=do.call('rbind',sapply(ind_vars, tab_ind_function6))

ind_vars_freqs_data=do.call('rbind',sapply(ind_vars, tab_ind_function_all))

###combined results - distribution:
all_freqs1_6=cbind(ind_vars_freqs1,ind_vars_freqs2,ind_vars_freqs3,ind_vars_freqs4,ind_vars_freqs5,ind_vars_freqs6)


###Tabulation of each message:
tab_function = function (datum = q1_data, variables = q1_reasons, main_q = NULL, strat_var=NULL)
{
  if (!is.null(main_q)==T)
  {
    datum = subset (datum, datum[,main_q]== strat_var)
    lab =c (paste0(main_q,' - ',strat_var,' (n = ', nrow(datum),')'), rep('',length(variables)-1))
  }
  
  else if (!is.null(main_q)==F)
  {
    datum = datum
    lab =c (paste0(main_q,' (n = ', nrow(datum),')'), rep('',length(variables)-1))
  }
  
  eval(parse(text=paste0('n_res',1:length(variables),'= table(datum$',variables,') ["1"]', sep = '\n')))
  eval(parse(text=paste0('prop_res',1:length(variables),'= round((prop.table(table(datum$',variables,'))*100) ["1"],1)', sep = '\n')))
  all_n_res=eval(parse(text=paste0('c(',paste0('n_res',1:length(variables),collapse = ','),')')))
  all_prop_res=eval(parse(text=paste0('c(',paste0('prop_res',1:length(variables),collapse = ','),')')))
  all_n_prop_res=cbind(lab,variables,all_n_res, all_prop_res)
  colnames(all_n_prop_res)=c('Question','Variables', 'n', "%")
  return (all_n_prop_res)
}


###Calling the tabulation function
msg_dist1= tab_function (datum = q1_data, variables =c(q1_reasons,"rqa_s02e01_NA" ,"rqa_s02e01_NS","rqa_s02e01_NC",                                        
                                                       "rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"))
msg_dist2= tab_function (datum = q2_data, variables =c(q2_reasons,"rqa_s02e02_NA" ,"rqa_s02e02_NS","rqa_s02e02_NC",                                        
                                                       "rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"))

msg_dist3= tab_function (datum = q3_data, variables =c(q3_reasons,"rqa_s02e03_NA" ,"rqa_s02e03_NS","rqa_s02e03_NC",                                        
                                                       "rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"))

msg_dist4_yes=tab_function (datum = q4_data, variables = c(q4_yes_reasons,"rqa_s02e04_NA" ,"rqa_s02e04_NS","rqa_s02e04_NC",                                        
                                                           "rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"), 
                            main_q = 'rqa_s02e04_yes_no_amb', strat_var='yes') 

msg_dist4_no=tab_function (datum = q4_data, variables = c(q4_no_reasons,"rqa_s02e04_NA" ,"rqa_s02e04_NS","rqa_s02e04_NC",                                        
                                                          "rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"), 
                           main_q = 'rqa_s02e04_yes_no_amb', strat_var='no') 
msg_dist4_amb=tab_function (datum = q4_data, variables = c(q4_yes_reasons,q4_no_reasons,"rqa_s02e04_NA" ,"rqa_s02e04_NS","rqa_s02e04_NC",                                        
                                                           "rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"), 
                            main_q = 'rqa_s02e04_yes_no_amb', strat_var='ambivalent') 


msg_dist5_yes=tab_function (datum = q5_data, variables = c(q5_yes_reasons,"rqa_s02e05_NA" ,"rqa_s02e05_NS","rqa_s02e05_NC",                                        
                                                           "rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"), 
                            main_q = 'rqa_s02e05_yes_no_amb', strat_var='yes') 

msg_dist5_no=tab_function (datum = q5_data, variables = c(q5_no_reasons,"rqa_s02e05_NA" ,"rqa_s02e05_NS","rqa_s02e05_NC",                                        
                                                          "rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"), 
                           main_q = 'rqa_s02e05_yes_no_amb', strat_var='no') 
msg_dist5_amb=tab_function (datum = q5_data, variables = c(q5_yes_reasons,q5_no_reasons,"rqa_s02e05_NA" ,"rqa_s02e05_NS","rqa_s02e05_NC",                                        
                                                           "rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"), 
                            main_q = 'rqa_s02e05_yes_no_amb', strat_var='ambivalent') 


msg_dist6_yes=tab_function (datum = q6_data, variables = c(q6_yes_reasons,"rqa_s02e06_NA" ,"rqa_s02e06_NS","rqa_s02e06_NC",                                        
                                                           "rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"), 
                            main_q = 'rqa_s02e06_yes_no_amb', strat_var='yes') 

msg_dist6_no=tab_function (datum = q6_data, variables = c(q6_no_reasons,"rqa_s02e06_NA" ,"rqa_s02e06_NS","rqa_s02e06_NC",                                        
                                                          "rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"), 
                           main_q = 'rqa_s02e06_yes_no_amb', strat_var='no') 
msg_dist6_amb=tab_function (datum = q6_data, variables = c(q6_yes_reasons,q6_no_reasons,"rqa_s02e06_NA" ,"rqa_s02e06_NS","rqa_s02e06_NC",                                        
                                                           "rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"), 
                            main_q = 'rqa_s02e06_yes_no_amb', strat_var='ambivalent') 

all_msgs=rbind(msg_dist1,msg_dist2,msg_dist3,msg_dist4_yes,msg_dist4_no,msg_dist4_amb,msg_dist5_yes,msg_dist5_no,msg_dist5_amb,
               msg_dist6_yes,msg_dist6_no,msg_dist6_amb)


#####Relevance analysis:

eval(parse(text=paste0('table(',paste0('q1_data$',q1_reasons,'==1', collapse = '|'),')')))['TRUE']/nrow(q1_data)
eval(parse(text=paste0('table(',paste0('q2_data$',q2_reasons,'==1', collapse = '|'),')')))['TRUE']/nrow(q2_data)
eval(parse(text=paste0('table(',paste0('q3_data$',q3_reasons,'==1', collapse = '|'),')')))['TRUE']/nrow(q3_data)

sum(table(q4_data$rqa_s02e04_yes_no_amb)[c('ambivalent','yes','no')])/nrow(q4_data)
###relevant reasons!
table(q4_data$rqa_s02e04_yes_no_amb)[c('ambivalent','yes','no')]
eval(parse(text=paste0("table(q4_data$rqa_s02e04_yes_no_amb=='yes' & (",paste0('q4_data$',q4_yes_reasons,'==1', collapse = '|'),'))')))['TRUE']/nrow(q4_data[q4_data$rqa_s02e04_yes_no_amb=='yes',])
eval(parse(text=paste0("table(q4_data$rqa_s02e04_yes_no_amb=='no' & (",paste0('q4_data$',q4_no_reasons,'==1', collapse = '|'),'))')))['TRUE']/nrow(q4_data[q4_data$rqa_s02e04_yes_no_amb=='no',])
eval(parse(text=paste0("table(q4_data$rqa_s02e04_yes_no_amb=='ambivalent' & (",paste0('q4_data$',c(q4_yes_reasons,q4_no_reasons),'==1', collapse = '|'),'))')))['TRUE']/nrow(q4_data[q4_data$rqa_s02e04_yes_no_amb=='ambivalent',])

table(q5_data$rqa_s02e05_yes_no_amb)[c('ambivalent','yes','no')]
eval(parse(text=paste0("table(q5_data$rqa_s02e05_yes_no_amb=='yes' & (",paste0('q5_data$',q5_yes_reasons,'==1', collapse = '|'),'))')))['TRUE']/nrow(q5_data[q5_data$rqa_s02e05_yes_no_amb=='yes',])
eval(parse(text=paste0("table(q5_data$rqa_s02e05_yes_no_amb=='no' & (",paste0('q5_data$',q5_no_reasons,'==1', collapse = '|'),'))')))['TRUE']/nrow(q5_data[q5_data$rqa_s02e05_yes_no_amb=='no',])
eval(parse(text=paste0("table(q5_data$rqa_s02e05_yes_no_amb=='ambivalent' & (",paste0('q5_data$',c(q5_yes_reasons,q5_no_reasons),'==1', collapse = '|'),'))')))['TRUE']/nrow(q5_data[q5_data$rqa_s02e05_yes_no_amb=='ambivalent',])

table(q6_data$rqa_s02e06_yes_no_amb)[c('ambivalent','yes','no')]
eval(parse(text=paste0("table(q6_data$rqa_s02e06_yes_no_amb=='yes' & (",paste0('q6_data$',q6_yes_reasons,'==1', collapse = '|'),'))')))['TRUE']/nrow(q6_data[q6_data$rqa_s02e06_yes_no_amb=='yes',])
eval(parse(text=paste0("table(q6_data$rqa_s02e06_yes_no_amb=='no' & (",paste0('q6_data$',q6_no_reasons,'==1', collapse = '|'),'))')))['TRUE']/nrow(q6_data[q6_data$rqa_s02e06_yes_no_amb=='no',])
eval(parse(text=paste0("table(q6_data$rqa_s02e06_yes_no_amb=='ambivalent' & (",paste0('q6_data$',c(q6_yes_reasons,q6_no_reasons),'==1', collapse = '|'),'))')))['TRUE']/nrow(q6_data[q6_data$rqa_s02e06_yes_no_amb=='ambivalent',])


###Analysis of messages:
eval(parse(text=paste0('q1_data$',c(q1_reasons,"rqa_s02e01_NA" ,"rqa_s02e01_NS","rqa_s02e01_NC","rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"),'=as.numeric(as.character(',
                       'q1_data$',c(q1_reasons,"rqa_s02e01_NA" ,"rqa_s02e01_NS","rqa_s02e01_NC","rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('q1_data$',q1_reasons, collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('q1_data$',c(q1_reasons,"rqa_s02e01_NA" ,"rqa_s02e01_NS","rqa_s02e01_NC","rqa_s02e01_NR","rqa_s02e01_NIC","rqa_s02e01_STOP","rqa_s02e01_WS"), collapse=','),")")))
##
eval(parse(text=paste0('q2_data$',c(q2_reasons,"rqa_s02e02_NA" ,"rqa_s02e02_NS","rqa_s02e02_NC","rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"),'=as.numeric(as.character(',
                       'q2_data$',c(q2_reasons,"rqa_s02e02_NA" ,"rqa_s02e02_NS","rqa_s02e02_NC","rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('q2_data$',q2_reasons, collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('q2_data$',c(q2_reasons,"rqa_s02e02_NA" ,"rqa_s02e02_NS","rqa_s02e02_NC","rqa_s02e02_NR","rqa_s02e02_NIC","rqa_s02e02_STOP","rqa_s02e02_WS"), collapse=','),")")))

##
eval(parse(text=paste0('q3_data$',c(q3_reasons,"rqa_s02e03_NA" ,"rqa_s02e03_NS","rqa_s02e03_NC","rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"),'=as.numeric(as.character(',
                       'q3_data$',c(q3_reasons,"rqa_s02e03_NA" ,"rqa_s02e03_NS","rqa_s02e03_NC","rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('q3_data$',q3_reasons, collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('q3_data$',c(q3_reasons,"rqa_s02e03_NA" ,"rqa_s02e03_NS","rqa_s02e03_NC","rqa_s02e03_NR","rqa_s02e03_NIC","rqa_s02e03_STOP","rqa_s02e03_WS"), collapse=','),")")))

##Q4
eval(parse(text=paste0('q4_data$',c(q4_yes_reasons,q4_no_reasons,"rqa_s02e04_NA" ,"rqa_s02e04_NS","rqa_s02e04_NC","rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"),'=as.numeric(as.character(',
                       'q4_data$',c(q4_yes_reasons,q4_no_reasons,"rqa_s02e04_NA" ,"rqa_s02e04_NS","rqa_s02e04_NC","rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('q4_data$',c(q4_yes_reasons,q4_no_reasons), collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('q4_data$',c(q4_yes_reasons,q4_no_reasons,"rqa_s02e04_NA" ,"rqa_s02e04_NS","rqa_s02e04_NC","rqa_s02e04_NR","rqa_s02e04_NIC","rqa_s02e04_STOP","rqa_s02e04_WS"), collapse=','),")")))

##Q 5

eval(parse(text=paste0('q5_data$',c(q5_yes_reasons,q5_no_reasons,"rqa_s02e05_NA" ,"rqa_s02e05_NS","rqa_s02e05_NC","rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"),'=as.numeric(as.character(',
                       'q5_data$',c(q5_yes_reasons,q5_no_reasons,"rqa_s02e05_NA" ,"rqa_s02e05_NS","rqa_s02e05_NC","rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('q5_data$',c(q5_yes_reasons,q5_no_reasons), collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('q5_data$',c(q5_yes_reasons,q5_no_reasons,"rqa_s02e05_NA" ,"rqa_s02e05_NS","rqa_s02e05_NC","rqa_s02e05_NR","rqa_s02e05_NIC","rqa_s02e05_STOP","rqa_s02e05_WS"), collapse=','),")")))

##Q 6
eval(parse(text=paste0('q6_data$',c(q6_yes_reasons,q6_no_reasons,"rqa_s02e06_NA" ,"rqa_s02e06_NS","rqa_s02e06_NC","rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"),'=as.numeric(as.character(',
                       'q6_data$',c(q6_yes_reasons,q6_no_reasons,"rqa_s02e06_NA" ,"rqa_s02e06_NS","rqa_s02e06_NC","rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"),"))", sep = '\n')))
eval(parse(text=paste0('sum(',paste0('q6_data$',c(q6_yes_reasons,q6_no_reasons), collapse=','),")")))
eval(parse(text=paste0('sum(',paste0('q6_data$',c(q6_yes_reasons,q6_no_reasons,"rqa_s02e06_NA" ,"rqa_s02e06_NS","rqa_s02e06_NC","rqa_s02e06_NR","rqa_s02e06_NIC","rqa_s02e06_STOP","rqa_s02e06_WS"), collapse=','),")")))




####---------Cross tabulations:

#Table 11 a: Recently displaced vs IDP camp

table(data$recently_displaced, data$idp_camp, useNA = 'ifany')
round(prop.table(table(data$recently_displaced, data$idp_camp, useNA = 'ifany'))*100)

##IDP camp vs Household language
table(data$household_language,data$idp_camp, useNA = 'ifany')
round(prop.table(table(data$household_language,data$idp_camp, useNA = 'ifany'))*100)

##Gender vs Age category
table(data$gender,data$age_cat, useNA = 'ifany')
round(prop.table(table(data$gender,data$age_cat, useNA = 'ifany'))*100)

##Operator vs region
table(data$region,data$operator, useNA = 'ifany')
round(prop.table(table(data$region,data$operator, useNA = 'ifany'))*100)

##Operator vs state
table(data$state,data$operator, useNA = 'ifany')
round(prop.table(table(data$state,data$operator, useNA = 'ifany'))*100)

##Recently displaced vs District
rd1=table(data$district,data$recently_displaced, useNA = 'ifany')
rd1p=round(prop.table(table(data$district,data$recently_displaced, useNA = 'ifany'))*100)

all_freq_dist_displaced=cbind(
  paste0(rd1[,1],' (',rd1p[,1],'%)'),
  paste0(rd1[,2],' (',rd1p[,2],'%)'),
  paste0(rd1[,3],' (',rd1p[,3],'%)'),
  paste0(rd1[,4],' (',rd1p[,4],'%)'),
  paste0(rd1[,5],' (',rd1p[,5],'%)'),
  paste0(rd1[,6],' (',rd1p[,6],'%)'),
  paste0(rd1[,7],' (',rd1p[,7],'%)'))

##IDP camp vs District
rd1=table(data$district,data$idp_camp, useNA = 'ifany')
rd1p=round(prop.table(table(data$district,data$idp_camp, useNA = 'ifany'),1)*100)

all_freq_dist_displaced=cbind(
  paste0(rd1[,1],' (',rd1p[,1],'%)'),
  paste0(rd1[,2],' (',rd1p[,2],'%)'),
  paste0(rd1[,3],' (',rd1p[,3],'%)'),
  paste0(rd1[,4],' (',rd1p[,4],'%)'),
  paste0(rd1[,5],' (',rd1p[,5],'%)'),
  paste0(rd1[,6],' (',rd1p[,6],'%)'),
  paste0(rd1[,7],' (',rd1p[,7],'%)'))


###Quick analysis on ambivalent responses:
eval(parse(text=paste0('table(q4_data$rqa_s02e04_yes_no_amb=="ambivalent" & (',paste0('q4_data$',q4_no_reasons, '==0',collapse = "&"),') & (',paste0('q4_data$',q4_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']
eval(parse(text=paste0('table(q4_data$rqa_s02e04_yes_no_amb=="ambivalent" & (',paste0('q4_data$',q4_no_reasons, '==1',collapse = "|"),') & (',paste0('q4_data$',q4_yes_reasons, '==0',collapse = "&"),'))')))['TRUE']
eval(parse(text=paste0('table(q4_data$rqa_s02e04_yes_no_amb=="ambivalent" & (',paste0('q4_data$',q4_no_reasons, '==0',collapse = "&"),') & (',paste0('q4_data$',q4_yes_reasons, '==0',collapse = "&"),'))')))['TRUE']
eval(parse(text=paste0('table(q4_data$rqa_s02e04_yes_no_amb=="ambivalent" & (',paste0('q4_data$',q4_no_reasons, '==1',collapse = "|"),') & (',paste0('q4_data$',q4_yes_reasons, '==1',collapse = "|"),'))')))['TRUE']

###UIDs with ambivalent codes on Qs 4 - 6:
q1_data$uid=as.factor(as.character(q1_data$uid))
q2_data$uid=as.factor(as.character(q2_data$uid))
q3_data$uid=as.factor(as.character(q3_data$uid))
q4_data$uid=as.factor(as.character(q4_data$uid))
q5_data$uid=as.factor(as.character(q5_data$uid))
q6_data$uid=as.factor(as.character(q6_data$uid))


data$uid=as.factor(as.character(data$uid))


wk4_uids_exclude_ambivalent=as.character(q4_data$uid[q4_data$rqa_s02e04_yes_no_amb=='ambivalent'])
wk5_uids_exclude_ambivalent=as.character(q5_data$uid[q5_data$rqa_s02e05_yes_no_amb=='ambivalent'])
wk6_uids_exclude_ambivalent=as.character(q6_data$uid[q6_data$rqa_s02e06_yes_no_amb=='ambivalent'])


#########################----------------------CLEANED DATASET---------------------------########################################################


cleaned_wk1_dataset=q1_data[!(as.character(q1_data$uid) %in% as.character(wk1_uids_exclude_1)),]
cleaned_wk2_dataset=q2_data[!(as.character(q2_data$uid) %in% as.character(wk2_uids_exclude_2)),]
cleaned_wk3_dataset=q3_data[!(as.character(q3_data$uid) %in% as.character(wk3_uids_exclude_3)),]
cleaned_wk4_dataset=q4_data[!(as.character(q4_data$uid) %in% as.character(na.omit(wk4_uids_exclude_ambivalent),wk4_uids_exclude_4, wk4_uids_exclude_5)),]
cleaned_wk5_dataset=q5_data[!(as.character(q5_data$uid) %in% as.character(na.omit(wk5_uids_exclude_ambivalent),wk5_uids_exclude_6, wk5_uids_exclude_7)),]
cleaned_wk6_dataset=q6_data[!(as.character(q6_data$uid) %in% as.character(na.omit(wk6_uids_exclude_ambivalent),wk6_uids_exclude_8, wk6_uids_exclude_9,wk6_uids_exclude_10)),]

###Converting the ID variables to factor type:
cleaned_wk1_dataset$uid=as.factor(cleaned_wk1_dataset$uid)
cleaned_wk2_dataset$uid=as.factor(cleaned_wk2_dataset$uid)
cleaned_wk3_dataset$uid=as.factor(cleaned_wk3_dataset$uid)
cleaned_wk4_dataset$uid=as.factor(cleaned_wk4_dataset$uid)
cleaned_wk5_dataset$uid=as.factor(cleaned_wk5_dataset$uid)
cleaned_wk6_dataset$uid=as.factor(cleaned_wk6_dataset$uid)


#######################------------------Merged clean data--------------------------#########################################################
unique_uids_across_wk1_6=na.omit(unique(c(as.character(cleaned_wk1_dataset$uid),as.character(cleaned_wk2_dataset$uid),
                                  as.character(cleaned_wk3_dataset$uid),as.character(cleaned_wk4_dataset$uid),
                                  as.character(cleaned_wk5_dataset$uid),as.character(cleaned_wk6_dataset$uid))))

merged_cleaned_data=data[(as.character(data$uid) %in% as.character(unique_uids_across_wk1_6)),]

####Exporting cleaned datasets to google drive:
write.csv(cleaned_wk1_dataset, file ='C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_/partially_cleaned_datasets/cleaned_wk1_dataset.csv')
write.csv(cleaned_wk2_dataset, file ='C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_/partially_cleaned_datasets/cleaned_wk2_dataset.csv')
write.csv(cleaned_wk3_dataset, file ='C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_/partially_cleaned_datasets/cleaned_wk3_dataset.csv')
write.csv(cleaned_wk4_dataset, file ='C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_/partially_cleaned_datasets/cleaned_wk4_dataset.csv')
write.csv(cleaned_wk5_dataset, file ='C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_/partially_cleaned_datasets/cleaned_wk5_dataset.csv')
write.csv(cleaned_wk6_dataset, file ='C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_/partially_cleaned_datasets/cleaned_wk6_dataset.csv')
write.csv(merged_cleaned_data, file ='C:/Users/lmalla/Google Drive/04 ADSS (EU Delegation to Somalia_Durable Solutions_2018)/03. Analysis/Quant analysis_/partially_cleaned_datasets/merged_cleaned_data.csv')

####-----------------------END-------------------------------########################

