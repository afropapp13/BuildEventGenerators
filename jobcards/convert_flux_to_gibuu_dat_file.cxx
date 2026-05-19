#include <TFile.h>
#include <TH1.h>

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

int convert_flux_to_dat() {

    // =========================
    // User settings
    // =========================
    const char* rootFile   = "/pnfs/sbnd/persistent/users/apapadop/Fluxes/Gen1.root";
    const char* histName   = "flux_sbnd_numu";
    const char* outputFile = "flux_sbnd_numu.dat";

    // Number of equally spaced output points
    const int nPoints = 1000;
    // =========================

    // Open ROOT file
    TFile *f = TFile::Open(rootFile, "READ");

    if (!f || f->IsZombie()) {
        std::cerr << "Error opening ROOT file: " << rootFile << std::endl;
        return 1;
    }

    // Get histogram
    TH1 *h = dynamic_cast<TH1*>(f->Get(histName));

    if (!h) {
        std::cerr << "Histogram not found: " << histName << std::endl;
        return 1;
    }

    // Get histogram range
    double emin = h->GetXaxis()->GetXmin();
    double emax = h->GetXaxis()->GetXmax();

    // Linear spacing
    double step = (emax - emin) / (nPoints - 1);

    // Open output file
    std::ofstream out(outputFile);

    if (!out.is_open()) {
        std::cerr << "Could not open output file." << std::endl;
        return 1;
    }

    // Write: energy   flux
    for (int i = 0; i < nPoints; ++i) {

        double energy = emin + i * step;

        // Interpolate histogram
        double flux = h->Interpolate(energy);

        out << energy << " " << flux << "\n";
    }

    out.close();
    f->Close();

    std::cout << "Wrote " << outputFile << std::endl;

    return 0;
}