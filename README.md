# Astraea III: A decentralized blockchain oracle
This is the matlab repo for figures used in the paper submitted to [BRAINS2020 conference](https://brains.dnac.org/). The full paper can be found on [IEEE Xplore](https://ieeexplore.ieee.org/document/9223272).

# Abstract of the paper
Many blockchain applications use decentralized oracles to trustlessly retrieve external information as those platforms are agnostic to real-world information. Some existing decentralized oracle protocols make use of majority-voting schemes to determine the outcomes and/or rewards to participants. In these cases, the awards (or penalties) grow linearly to the participant stakes, therefore voters are indifferent between voting through a single or multiple identities. Furthermore, the voters receive a reward only when they agree with the majority outcome, a tactic that may lead to herd behavior. This paper proposes an oracle protocol based on peer prediction mechanisms with non-linear staking rules. In the proposed approach, instead of being rewarded when agreeing with a majority outcome, a voter receives awards when their report achieves a relatively high score based on a peer prediction scoring scheme. The scoring scheme is designed to be incentive compatible so that the maximized expected score is achieved only with honest reporting. A non-linear stake scaling rule is proposed to discourage Sybil attacks. This paper also provides a theoretical analysis and guidelines for implementation as reference.

# General Ideas
What we tried to do is to decouple voting power and award scheme. So that the expected award is strictly the highest when voting honestly according to the voter's opinion. Thanks to all the existing scoring rules, we were able to come up with a light weight scoring rule based on randomization. 

We also use a set of rules to scale voter's voting power and award so that the system designer can potentially set the desired size of voting pools. 
