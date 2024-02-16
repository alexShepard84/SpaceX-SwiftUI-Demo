//
//  Formatter.swift
//  SwiftShowcase
//
//  Created by Alex Schäfer on 08.02.24.
//
// This file contains extensions and utilities for formatting various types of data.
// It enhances basic data types with additional formatting capabilities.

import Foundation

enum Formatter { }

extension Double {
    /// Formats the `Double` value as a mass measurement.
    ///
    /// Converts the `Double` value to a `Measurement` object with the specified mass unit
    /// and returns a localized string representing the mass.
    ///
    /// - Parameter unit: A `UnitMass` value representing the unit of mass (e.g., kilograms, pounds).
    /// - Returns: A `String` representing the formatted mass value with the unit.
    ///
    /// Usage Example:
    /// ```
    /// let massInKilograms = 100.0
    /// let formattedMass = massInKilograms.massFormatter(unit: .kilograms)
    /// print(formattedMass) // Output: "100 kg"
    /// ```
    func massFormatter(unit: UnitMass) -> String {
        let measurement = Measurement(value: self, unit: unit)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: measurement)
    }

    /// Formats the `Double` value as a length measurement.
    ///
    /// Converts the `Double` value to a `Measurement` object with the specified length unit
    /// and returns a localized string representing the length.
    ///
    /// - Parameter unit: A `UnitLength` value representing the unit of length (e.g., meters, feet).
    /// - Returns: A `String` representing the formatted length value with the unit.
    ///
    /// Usage Example:
    /// ```
    /// let lengthInMeters = 100.0
    /// let formattedLength = lengthInMeters.lengthFormatter(unit: .meters)
    /// print(formattedLength) // Output: "100 m"
    /// ```
    func lengthFormatter(unit: UnitLength) -> String {
        let measurement = Measurement(value: self, unit: unit)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: measurement)
    }
}
