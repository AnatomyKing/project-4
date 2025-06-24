<?php

namespace App\Http\Controllers;

use App\Models\Prestatie;
use Illuminate\Http\Request;

class PrestatieController extends Controller
{
    /**
     * Haal alle prestaties op van de ingelogde gebruiker.
     */
    public function index(Request $request)
    {
        $user = $request->user();
        // ← use 'gebruiker_id' here
        $prestaties = Prestatie::where('gebruiker_id', $user->id)->get();

        return response()->json($prestaties);
    }

    /**
     * Maak een nieuwe prestatie aan voor de ingelogde gebruiker.
     */
    public function store(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'oefening_id' => 'required|exists:oefeningen,id',
            'datum'       => 'required|date',
            'starttijd'   => 'nullable|date_format:H:i:s',
            'eindtijd'    => 'nullable|date_format:H:i:s',
            'aantal'      => 'required|integer|min:1',
        ]);

        // ← correctly name the FK
        $validated['gebruiker_id'] = $user->id;

        $prestatie = Prestatie::create($validated);

        return response()->json($prestatie, 201);
    }

    /**
     * Toon een specifieke prestatie (alleen van ingelogde gebruiker).
     */
    public function show(Request $request, Prestatie $prestatie)
    {
        $user = $request->user();

        // ← check 'gebruiker_id'
        if ($prestatie->gebruiker_id !== $user->id) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        return response()->json($prestatie);
    }

    /**
     * Update een prestatie (alleen van ingelogde gebruiker).
     */
    public function update(Request $request, Prestatie $prestatie)
    {
        $user = $request->user();

        if ($prestatie->gebruiker_id !== $user->id) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'aantal' => 'sometimes|required|integer|min:1',
            // of andere velden die je wilt toestaan
        ]);

        $prestatie->update($validated);

        return response()->json($prestatie);
    }

    /**
     * Verwijder een prestatie (alleen van ingelogde gebruiker).
     */
    public function destroy(Request $request, Prestatie $prestatie)
    {
        $user = $request->user();

        if ($prestatie->gebruiker_id !== $user->id) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        $prestatie->delete();

        return response()->json(null, 204);
    }
}
