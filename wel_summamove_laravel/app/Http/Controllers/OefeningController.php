<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Oefening;

class OefeningController extends Controller
{
    /**
     * Display a listing of all oefeningen (publiek).
     */
    public function index()
    {
        return Oefening::all();
    }

    /**
     * Display the specified oefening.
     */
    public function show(Oefening $oefening)
    {
        return response()->json($oefening);
    }

    /**
     * Store a newly created oefening (beveiligd).
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'naam'             => 'required|string|max:100',
            'beschrijving_nl'  => 'required|string',
            'beschrijving_en'  => 'nullable|string',
            'afbeelding_url'   => 'nullable|url',    // ← toegevoegd
        ]);

        $oefening = Oefening::create($validated);

        return response()->json($oefening, 201);
    }

    /**
     * Update the specified oefening (beveiligd).
     */
    public function update(Request $request, Oefening $oefening)
    {
        $validated = $request->validate([
            'naam'             => 'required|string|max:100',
            'beschrijving_nl'  => 'required|string',
            'beschrijving_en'  => 'nullable|string',
            'afbeelding_url'   => 'nullable|url',    // ← toegevoegd
        ]);

        $oefening->update($validated);

        return response()->json($oefening);
    }

    /**
     * Remove the specified oefening (beveiligd).
     */
    public function destroy(Oefening $oefening)
    {
        $oefening->delete();

        return response()->json(['message' => 'Oefening verwijderd']);
    }
}
