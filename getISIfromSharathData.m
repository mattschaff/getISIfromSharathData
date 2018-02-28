function output = getISIfromSharathData( neuronCollectorFile )
%getISIfromSharathData extracts ISI violation rates from YECohen data
%   INPUT
%       neuronCollectorFile: file path of NeuronCollector output from
%       schaffCorrelate function
% https://github.com/mattschaff/oldCorrelationWork/blob/master/testMatt2.m
%   OUTPUT
%       output.isiViolationsPerNeuron: 1xN vector of ISI violation rates
%           per neuron
%       output.avgPercentISIviolations: the arithmetic mean of 
%           output.isiViolationsPerNeuron
    load(neuronCollectorFile);
    numNeurons = numel(NeuronCollector);
    isiViolationPercent = zeros([1 numNeurons]);
    for i=1:numNeurons
        disp(['Generating ISI for neuron ' num2str(NeuronCollector(i).ID)]);
        % loop thorugh trials
        numTrials = numel([NeuronCollector(i).trials]);
        trials = [NeuronCollector(i).trials];
        numISIviolations = 0;
        for j=1:numTrials
            numISIviolations = numISIviolations + sum(diff(trials(j).spikes) < 3); % in ms
        end
        isiViolationPercent(i) = numISIviolations/numel([trials.spikes]);
    end
    output.isiViolationsPerNeuron = isiViolationPercent;
    output.avgPercentISIviolations = mean(isiViolationPercent);
end

